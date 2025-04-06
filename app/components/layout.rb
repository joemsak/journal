# frozen_string_literal: true

class Components::Layout < Components::Base
  include Phlex::Rails::Layout

  def initialize(title:)
    @title = title
  end

  def view_template
    doctype

    html do
      head do
        title { @title }
        meta(name: :viewport, content: "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no")
        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag(:app, "data-turbo-track": "reload")
        javascript_importmap_tags
      end

      body { yield }
    end
  end
end
