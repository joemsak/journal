# frozen_string_literal: true

class Components::Layout < Components::Base
  include Phlex::Rails::Layout

  attr_reader :title

  def initialize(title:)
    @title = "#{title} &bull; Technical Journal"
  end

  def view_template
    doctype

    html do
      head do
        title { raw safe(title) }
        meta(name: :viewport, content: "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no")
        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag(:app, "data-turbo-track": "reload")
        script(src: "https://kit.fontawesome.com/b40bcfed01.js", crossorigin: :anonymous)
        javascript_importmap_tags
      end

      body { yield }
    end
  end
end
