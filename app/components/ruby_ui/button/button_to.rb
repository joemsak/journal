class RubyUI::ButtonTo < RubyUI::Button
  include Phlex::Rails::Helpers::ButtonTo

  attr_reader :path

  def initialize(
    path:,
    type: :button,
    variant: :primary,
    size: :md,
    icon: false,
    **attrs
  )
    @path = path
    super(type:, variant:, size:, icon:, **attrs)
  end

  def view_template(&)
    button_to(path, **attrs, &)
  end
end
