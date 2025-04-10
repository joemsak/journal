class Components::TipTap::Toolbar < Components::Base
  def view_template
    div(class: "flex justify-between items-center") do
      div(class: "flex gap-2") do
        render Button.new(
          target: :heading1,
          action: "toggleHeading",
          params: { level: 1 },
          title: "Heading 1",
          icon: "angles-up"
        )

        render Button.new(
          target: :heading2,
          action: "toggleHeading",
          params: { level: 2 },
          title: "Heading 2",
          icon: "angle-up"
        )

        render Button.new(
          target: :bulletList,
          action: "toggleBulletList",
          title: "Bullet List",
          icon: "list-ul"
        )

        render Button.new(
          target: :blockQuote,
          action: "toggleBlockquote",
          title: "Blockquote",
          icon: "quote-left"
        )

        render Button.new(
          target: :codeBlock,
          action: "toggleCodeBlock",
          title: "Code Block",
          icon: "code"
        )
      end

      div do
        div(class: "hidden flex space-x-1 items-center", data: { tiptap_target: :savingDots }) do
          div(class: "dot w-2 h-2 bg-blue-500 rounded-full animate-pulse")
          div(class: "dot w-2 h-2 bg-blue-500 rounded-full animate-pulse delay-200")
          div(class: "dot w-2 h-2 bg-blue-500 rounded-full animate-pulse delay-400")
        end

        div(class: "hidden text-red-200", data: { tiptap_target: :errorText }) { "Error while saving" }
        div(class: "hidden text-gray-500", data: { tiptap_target: :savedText }) { "Saved" }
      end
    end
  end
end
