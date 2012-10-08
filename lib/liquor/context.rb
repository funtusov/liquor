module Liquor

  # Context keeps the variable stack and resolves variables, as well as keywords
  #
  #   context['variable'] = 'testing'
  #   context['variable'] #=> 'testing'
  #   context['true']     #=> true
  #   context['10.2232']  #=> 10.2232
  #
  #   context.stack do
  #      context['bob'] = 'bobsen'
  #   end
  #
  #   context['bob']  #=> nil  class Context
  class Context
    attr_reader :scopes, :errors, :registers, :environments

    def initialize(environments = {}, outer_scope = {}, registers = {}, rethrow_errors = false)
      @environments   = [environments].flatten
      @scopes         = [(outer_scope || {})]
      @registers      = registers
      @errors         = []
      @rethrow_errors = rethrow_errors
      squash_instance_assigns_with_environments
    end

    def strainer
      @strainer ||= Strainer.create(self)
    end

    # adds filters to this context.
    # this does not register the filters with the main Template object. see <tt>Template.register_filter</tt>
    # for that
    def add_filters(filters)
      filters = [filters].flatten.compact

      filters.each do |f|
        raise ArgumentError, "Expected module but got: #{f.class}" unless f.is_a?(Module)
        strainer.extend(f)
      end
    end

    def handle_error(e)
      errors.push(e)
      raise if @rethrow_errors

      case e
      when SyntaxError
        "Liquor syntax error: #{e.message.gsub("<", "&lt;").gsub(">", "&gt;")}"
        else
        "Liquor error: #{e.message.gsub("<", "&lt;").gsub(">", "&gt;")}"
      end
    end


    def invoke(method, *args)
      if args[0].class == Drop::DropProxy && args[0].has_scope?(method)
        scope_args = args[1..args.length-1]
        return args[0].send(method, *scope_args)
      end
      
      if strainer.respond_to?(method)
        strainer.__send__(method, *args)
      else
        args.first
      end
    end

    # push new local scope on the stack. use <tt>Context#stack</tt> instead
    def push(new_scope={})
      raise StackLevelError, "Nesting too deep" if @scopes.length > 100
      @scopes.unshift(new_scope)
    end

    # merge a hash of variables in the current local scope
    def merge(new_scopes)
      @scopes[0].merge!(new_scopes)
    end

    # pop from the stack. use <tt>Context#stack</tt> instead
    def pop
      raise ContextError if @scopes.size == 1
      @scopes.shift
    end

    # pushes a new local scope on the stack, pops it at the end of the block
    #
    # Example:
    #
    #   context.stack do
    #      context['var'] = 'hi'
    #   end
    #   context['var]  #=> nil
    #
    def stack(new_scope={},&block)
      result = nil
      push(new_scope)
      begin
        result = yield
      ensure
        pop
      end
      result
    end
    
    def clear_instance_assigns
      @scopes[0] = {}
    end

    # Only allow String, Numeric, Hash, Array, Proc, Boolean or <tt>Liquor::Drop</tt>
    def []=(key, value)
      @scopes[0][key] = value
    end

    def [](key)
      resolve(key)
    end

    def has_key?(key)
      resolve(key) != nil
    end

    private

    # Look up variable, either resolve directly after considering the name. We can directly handle
    # Strings, digits, floats and booleans (true,false). If no match is made we lookup the variable in the current scope and
    # later move up to the parent blocks to see if we can resolve the variable somewhere up the tree.
    # Some special keywords return symbols. Those symbols are to be called on the rhs object in expressions
    #
    # Example:
    #
    #   products == empty #=> products.empty?
    #
    def resolve(key)
      case key
      when nil, 'nil', 'null', ''
        nil
      when 'true'
        true
      when 'false'
        false
      when 'blank'
        :blank?
      when 'empty'
        :empty?
      # Single quoted strings
      when /^'(.*)'$/
        $1.to_s
      # Double quoted strings
      when /^"(.*)"$/
        $1.to_s
      # Integer
      when /^([+-]?\d+)$/
        $1.to_i
      # Ranges
      when /^\((\S+)\.\.(\S+)\)$/
        (resolve($1).to_i..resolve($2).to_i)
      # Floats
      when /^([+-]?\d[\d\.]+)$/
        $1.to_f
      # filtered variables 	
      when SpacelessFilter
        filtered_variable(key)
      else
        variable(key)
      end
    end

    # fetches an object starting at the local scope and then moving up
    # the hierachy
    def find_variable(key)
      scope = @scopes.find { |s| s.has_key?(key) }
      if scope.nil?
        @environments.each do |e|
          if variable = lookup_and_evaluate(e, key)
            scope = e
            break
          end
        end
      end
      scope     ||= @environments.last || @scopes.last
      variable  ||= lookup_and_evaluate(scope, key)
      
      variable = variable.to_liquor
      
      if variable.class != Mongoid::Relation
        variable.context = self if variable.respond_to?(:context=)
      end
      return variable
    end

    # resolves namespaced queries gracefully.
    #
    # Example
    #
    #  @context['hash'] = {"name" => 'tobi'}
    #  assert_equal 'tobi', @context['hash.name']
    #  assert_equal 'tobi', @context['hash["name"]']
    #
    def variable(markup)
      parts = markup.scan(VariableParser)
      square_bracketed = /^\[(.*)\]$/

      first_part = parts.shift
      if first_part =~ square_bracketed
        first_part = resolve($1)
      end

      if object = find_variable(first_part)
        parts.each do |part|
          part = resolve($1) if part_resolved = (part =~ square_bracketed)
          # DropProxy was designed like named_scopes for implementing has_many and named_scope wrappers in LiquorDrops. 
          # DropProxy delegates most Array methods to its internal function to convert an array of ActiveRecord objects to
          # an array of liquor drops when you work with it like with an array. 
          #
          # Also it is absolutely safe not to call here to_liquor because when you will try to work with the result it will be automatically converted
          # to an array of drops. So you have no chance to do something crucial.
          #
          # Also when 'my_object.referenced_objects' expression evaluates, the 'object' should be a DropProxy, but you can find
          # that 'object = res.to_liquor' will convert it into an array. So 'to_liquor' method was defined in the DropProxy and always returns the itself.
          #
          if object.class == Mongoid::Relation && (['size', 'first', 'last', 'paginate'].include?(part) || part.is_a?(Integer))
            if part.is_a?(Integer)
              res = object[part]
            else
              res = object.send(part.intern)
            end
            
            object = res.to_liquor
          
          elsif object.class == Drop::DropProxy || object.is_a?(Drop) && (object.has_scope?(part) || object.has_many?(part))
            if part.is_a?(Integer)
              object = object[part]
            else 
              object = object.send(part.intern) rescue nil
            end

          # If object is a hash- or array-like object we look for the
          # presence of the key and if its available we return it
          elsif object.respond_to?(:[]) and
            ((object.respond_to?(:has_key?) and object.has_key?(part)) or
             (object.respond_to?(:fetch) and part.is_a?(Integer)))
            
            # if its a proc we will replace the entry with the proc
            # res = object[part]
            # res = object[part] = res.call(self) if res.is_a?(Proc) and object.respond_to?(:[]=)
            res = lookup_and_evaluate(object, part)
            object = res.to_liquor

          # Some special cases. If the part wasn't in square brackets and
          # no key with the same name was found we interpret following calls
          # as commands and call them on the current object
          elsif !part_resolved and object.respond_to?(part) and ['size', 'first', 'last'].include?(part)            
            object = object.send(part.intern).to_liquor

          # No key was present with the desired value and it wasn't one of the directly supported
          # keywords either. The only thing we got left is to return nil
          else
            return nil
          end

          # If we are dealing with a drop here we have to
          object.context = self if object.respond_to?(:context=)
        end
      end

      object
    end
    
    def lookup_and_evaluate(obj, key)
      if obj.class != Mongoid::Relation && (value = obj[key]).is_a?(Proc) && obj.respond_to?(:[]=)
        obj[key] = (value.arity == 0 ) ? value.call : value.call(self)
      else
        value
      end
    end
    
    def squash_instance_assigns_with_environments
      @scopes.last.each_key do |k|
        @environments.each do |env|
          if env.has_key?(k)
            scopes.last[k] = lookup_and_evaluate(env, k)
            break
          end
        end
      end
    end
    
    def filtered_variable(markup)
      Variable.new(markup).render(self)
    end
    
  end
end
