# frozen_string_literal: true

class Views::Contents::Show < Views::Base
  include Phlex::Rails::Helpers::LinkTo

  attr_reader :contents, :content, :title

  def self.url_regex = %r{
    \b
    (https?://|www\.)?            # Protocol (http or https) or www
    ([a-z0-9-]+(\.[a-z]{2,})+)    # Domain name
    (:[0-9]{1,5})?                # Port (optional)
    (/[^\s]*)?                    # Path (optional)
  }ix

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
        content.body.gsub(self.class.url_regex) do |url|
          scheme = url.start_with?("http://", "https://") ? "" : "http://"
          link_to(url, "#{scheme}#{url}", target: :_blank)
        end.html_safe
      end
    end
  end
end
