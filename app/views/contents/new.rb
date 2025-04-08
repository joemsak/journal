# frozen_string_literal: true

class Views::Contents::New < Views::Base
  attr_reader :contents, :content

  def initialize(contents:, content:)
    @contents = contents
    @content = content
  end

  def view_template
    Layout(title: "Today's Entry", contents:) do
      h1(class: "font-bold text-xl md:text-2xl") { "Daily Technical Journal" }
      p(class: "mt-4") { "Today's entry:" }

      render Components::TipTap::Editor.new(content:)
    end
  end
end
