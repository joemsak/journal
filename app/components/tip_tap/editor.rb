class Components::TipTap::Editor < Components::Base
  attr_reader :content

  def initialize(content:)
    @content = content
  end

  def view_template
    div(
      data: { controller: :tiptap, tiptap_content_value: content.body },
      class: "mt-4"
    ) do
      div(class: "flex gap-2") { render Toolbar.new }
      div(data: { tiptap_target: :editor }, class: "hidden mt-4 outline")
    end
  end
end
