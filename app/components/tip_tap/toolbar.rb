class Components::TipTap::Toolbar < Components::Base
  def view_template
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
end

