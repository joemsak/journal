# frozen_string_literal: true

class Views::Welcome::Show < Views::Base
  def view_template
    Layout(title: "Welcome") do
      h1 { "Hello, World" }
      p { "This is my Raspberry Pi 3" }
      div(data: {controller: :tiptap})
    end
  end
end
