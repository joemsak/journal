# frozen_string_literal: true

class Components::Layout < Components::Base
  include Phlex::Rails::Layout

  attr_reader :contents

  def initialize(title:, contents: [])
    @title = "#{title} &bull; Technical Journal"
    @contents = contents
  end

  def view_template
    doctype

    html do
      head do
        title { @title.html_safe }
        meta(name: :viewport, content: "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no")
        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag(:app, "data-turbo-track": "reload")
        script(src: "https://kit.fontawesome.com/b40bcfed01.js", crossorigin: :anonymous)
        javascript_importmap_tags
      end

      body(class: "flex h-screen flex-col flex-col-reverse justify-end md:flex-row") do
        div(class: "py-4 px-8 md:w-[284px] md:border-r border-gray-300") do
          render Nav.new(items: contents)
        end

        main(class: "py-4 px-8 md:grow-1") { yield }
      end
    end
  end
end
