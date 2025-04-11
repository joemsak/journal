# frozen_string_literal: true

class Components::Layout < Components::Base
  include Phlex::Rails::Layout

  attr_reader :entries, :navigation

  def initialize(title:, entries: [], navigation: true)
    @title = "#{title} &bull; Technical Journal"
    @entries = entries
    @navigation = navigation
  end

  def view_template
    doctype

    html(class: "h-full") do
      head do
        title { @title.html_safe }
        meta(name: :viewport, content: "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no")
        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag(:app, "data-turbo-track": "reload")
        script(src: "https://kit.fontawesome.com/b40bcfed01.js", crossorigin: :anonymous)
        javascript_importmap_tags
      end

      body(class: "min-h-full flex flex-col flex-col-reverse items-stretch justify-end md:flex-row") do
        if navigation
          div(class: "py-4 px-8 md:min-w-[284px] md:border-r border-gray-300") do
            render Nav.new(items: entries)
          end
        end

        main(class: "py-4 px-8 md:grow-1") { yield }
      end
    end
  end
end
