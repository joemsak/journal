class Components::TipTapButton <  Components::Base
  attr_reader :tiptap_target, :action, :params, :title, :icon

  def initialize(target:, action:, params: {}, title:, icon:)
    @tiptap_target = target
    @action = "tiptap##{action}"
    @params = params.transform_keys do |key|
      :"tiptap_#{key}_param"
    end
    @title = title
    @icon = icon
  end

  def view_template
    button(
      class: "block cursor-pointer px-4 py-2 outline rounded",
      data: { action:, tiptap_target:, **params },
      title:
    ) do
      i(class: "fa-solid fa-#{icon}")
    end
  end
end
