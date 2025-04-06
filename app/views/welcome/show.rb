# frozen_string_literal: true

class Views::Welcome::Show < Views::Base
  def initialize(content:)
    @content = content
  end

  def view_template
    Layout(title: "Welcome") do
      h1(class: "font-bold text-2xl") { "Daily Technical Journal" }
      p(class: "mt-4") { "Today's entry:" }
      div(data: { controller: :tiptap, tiptap_content_value: @content }, class: "mt-4 outline")
    end
  end
end
