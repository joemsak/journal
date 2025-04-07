# frozen_string_literal: true

class Views::Contents::New < Views::Base
  attr_reader :content

  def initialize(content:)
    @content = content
  end

  def view_template
    Layout(title: "Today's Entry") do
      h1(class: "font-bold text-2xl") { "Daily Technical Journal" }
      p(class: "mt-4") { "Today's entry:" }

      render Components::TipTapEditor.new(content:)
    end
  end
end
