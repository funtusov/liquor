class CsrfMeta < Liquor::Tag
  def render(context)
    controller = context.registers[:controller]
    name = controller.send(:request_forgery_protection_token).to_s
    value = controller.send(:form_authenticity_token)
    %{
    <meta name="csrf-param" content="#{name}">
    <meta name="csrf-token" content="#{value}">
    }
  end
end

Liquor::Template.register_tag('csrf_meta', CsrfMeta)
