require 'spec_helper'

describe Liquor::Compiler do
  it "correctly handles error workflow" do
    compiler = Liquor::Compiler.new
    compiler.errors.should be_empty

    compiler.compile '{{ $ }}'
    compiler.errors.should be_any
    compiler.code.should be_nil
    compiler.parse_tree.should be_nil

    compiler.compile '{{ a(t: 1 t: 1) }}'
    compiler.errors.should be_any
    compiler.code.should be_nil
    compiler.parse_tree.should_not be_nil

    compiler.compile '{{ "1" }}'
    compiler.errors.should be_empty
    compiler.code.should respond_to(:call)
    compiler.parse_tree.should_not be_nil
  end

  it "can compile plaintext" do
    exec('Hello World!').should == 'Hello World!'
  end

  it "can compile interpolations" do
    exec('Test: {{ "str" }}').should == 'Test: str'
  end

  it "correctly executes expressions" do
    exec('{{ 1 + 2 * 5 + 2 }}').should == '13'
    exec('{{ -6 - -6 }}').should == '0'
    exec('{{ ([1,2,3])[1] }}').should == '2'
  end

  it "handles unbound identifiers" do
    expect { compile('{{ i }}') }.to raise_error(Liquor::NameError, %r|is not bound|)
  end

  it "handles externals" do
    compiler = Liquor::Compiler.new
    compiler.compile '{{ i }}', [:i]
    compiler.code.call(i: 10).should == '10'
  end

  it "verifies function arguments" do
    compiler = Liquor::Compiler.new

    a = Liquor::Function.new("substr") do
      unnamed_arg true
      optional_named_args :from, :to

      body do |arg, kw|
        from, to = kw[:from] || 0, kw[:to] || -1
        arg[from..to]
      end
    end
    compiler.register_function a

    b = Liquor::Function.new("yield") do
      mandatory_named_args :buffer
      optional_named_args  :strip

      body do |arg, kw|
        # nothing
      end
    end
    compiler.register_function b

    compiler.compile! '{{ substr("hello world") }}'
    compiler.code.call.should == 'hello world'

    compiler.compile! '{{ substr("hello world" from: 6) }}'
    compiler.code.call.should == 'world'

    compiler.compile! '{{ substr("hello world" to: 4) }}'
    compiler.code.call.should == 'hello'

    compiler.compile! '{{ substr("hello world" from: 1 to: 3) }}'
    compiler.code.call.should == 'ell'

    expect {
      compiler.compile! '{{ substr() }}'
    }.to raise_error(Liquor::ArgumentError, %r|unnamed argument is required|)

    expect {
      compiler.compile! '{{ substr("a" test: 1) }}'
    }.to raise_error(Liquor::ArgumentError, %r|named argument `test' is not accepted|)

    expect {
      compiler.compile! '{{ yield() }}'
    }.to raise_error(Liquor::ArgumentError, %r|named argument `buffer' is required|)

    expect {
      compiler.compile! '{{ yield("a" buffer: "test") }}'
    }.to raise_error(Liquor::ArgumentError, %r|unnamed argument is not accepted|)
  end

  it "works with filter expressions" do
    compiler = Liquor::Compiler.new

    a = Liquor::Function.new("capitalize") do
      unnamed_arg true

      body do |arg, kw|
        arg.capitalize
      end
    end
    compiler.register_function a

    b = Liquor::Function.new("reverse") do
      unnamed_arg true

      body do |arg, kw|
        arg.reverse
      end
    end
    compiler.register_function b

    c = Liquor::Function.new("trim") do
      unnamed_arg true
      mandatory_named_args :length

      body do |arg, kw|
        arg[0...kw[:length]]
      end
    end
    compiler.register_function c

    compiler.compile '{{ "hello world" | reverse | trim length: 3 | capitalize }}'
    compiler.code.call.should == 'Dlr'
  end
end