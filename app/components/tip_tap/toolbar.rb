class Components::TipTap::Toolbar < Components::Base
  def view_template
    div(class: "flex justify-between items-center") do
      div(class: "flex gap-2") do
        render Button.new(
          target: :heading,
          action: :toggleHeading,
          title: :Heading,
          icon: :heading
        )

        render Button.new(
          target: :bold,
          action: :toggleBold,
          title: :Bold,
          icon: :bold
        )

        render Button.new(
          target: :bulletList,
          action: :toggleBulletList,
          title: "Bullet List",
          icon: "list-ul"
        )

        render Button.new(
          target: :blockQuote,
          action: :toggleBlockquote,
          title: :Blockquote,
          icon: "quote-left"
        )

        render Button.new(
          target: :codeBlock,
          action: :toggleCodeBlock,
          title: "Code Block",
          icon: :code
        )
      end

      div do
        div(class: "hidden flex space-x-0.5 items-center", data: { tiptap_target: :savingDots }) do
          div(class: "dot w-1 h-1 bg-blue-500 rounded-full animate-pulse")
          div(class: "dot w-1 h-1 bg-blue-500 rounded-full animate-pulse delay-100")
          div(class: "dot w-1 h-1 bg-blue-500 rounded-full animate-pulse delay-200")
        end

        div(class: "hidden text-red-400", data: { tiptap_target: :errorText }) { "Error while saving" }
        div(class: "hidden text-gray-500", data: { tiptap_target: :savedText }) { "Saved" }
      end
    end
  end
end
