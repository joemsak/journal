class Components::TipTap::Editor < Components::Base
  attr_reader :entry

  def initialize(entry:)
    @entry = entry
  end

  def view_template
    div(
      data: { controller: :tiptap, tiptap_content_value: entry.body },
      class: "mt-4"
    ) do
      render Toolbar.new
      div(data: { tiptap_target: :editor }, class: "hidden mt-4 outline")
    end
  end
end
