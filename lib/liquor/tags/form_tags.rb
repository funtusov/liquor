class FormParams < Liquor::Tag
  def render(context)
    controller = context.registers[:controller]
    name = controller.send(:request_forgery_protection_token).to_s
    value = controller.send(:form_authenticity_token)
    %{
      <div style="margin:0;padding:0;display:inline">
      <input name="utf8" type="hidden" value="&#x2713;" />
      <input name="#{name}" type="hidden" value="#{value}" />
      </div>
    }
  end
end

class FormDelete < Liquor::Tag
  def render(context)
    %{
      <input name="_method" type="hidden" value="delete" />
    }
  end
end

class FormPut < Liquor::Tag
  def render(context)
    %{
      <input name="_method" type="hidden" value="put" />
    }
  end
end

Liquor::Template.register_tag('form_params', FormParams)

Liquor::Template.register_tag('form_delete', FormDelete)

Liquor::Template.register_tag('form_put', FormPut)