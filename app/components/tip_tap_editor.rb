class Components::TipTapEditor < Components::Base
  def initialize(content:)
    @content = content
  end

  def view_template
    div(data: { controller: :tiptap, tiptap_content_value: @content }, class: "mt-4") do
      div(class: "flex gap-2") do
        render TipTapButton.new(
          target: :heading1,
          action: "toggleHeading",
          params: { tiptap_level_param: 1 },
          title: "Heading 1",
          icon: "angles-up"
        )

        render TipTapButton.new(
          target: :heading2,
          action: "toggleHeading",
          params: { tip_tap_level_param: 2 },
          title: "Heading 2",
          icon: "angle-up"
        )

        render TipTapButton.new(
          target: :blockQuote,
          action: "toggleBlockquote",
          title: "Blockquote",
          icon: "quote-left"
        )

        render TipTapButton.new(
          target: :codeBlock,
          action: "toggleCodeBlock",
          title: "Code Block",
          icon: "code"
        )
      end

      div(data: { tiptap_target: :editor }, class: "hidden mt-4 outline")
    end
  end
end
