class Components::TipTap::Editor < Components::Base
  attr_reader :entry

  def initialize(entry:)
    @entry = entry
  end

  def view_template
    div(
      class: "mt-4",
      data: {
        controller: :tiptap,
        tiptap_entry_id_value: entry.to_param,
        tiptap_content_value: entry.body
      }
    ) do
      render Toolbar.new
      div(data: { tiptap_target: :editor }, class: "hidden mt-4 outline")
    end
  end
end
