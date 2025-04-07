# frozen_string_literal: true

class Views::Contents::Show < Views::Base
  include Phlex::Rails::Helpers::LinkTo

  attr_reader :contents, :content, :title

  def initialize(contents:, content:)
    @contents = contents
    @content = content
    @title = "Entry for #{content.list_item_name}"
  end

  def view_template
    Layout(title:, contents:) do
      h1(class: "font-bold text-xl md:text-2xl") { title }
      link_to "&larr; back".html_safe, root_path, class: "text-blue-900 hover:underline"

      div(class: "mt-4 pt-4 border-t border-gray-300") do
        content.body.html_safe
      end
    end
  end
end
