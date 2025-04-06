# frozen_string_literal: true

class Components::Layout < Components::Base
  def initialize(title:)
    @title = title
  end

  def view_template
    doctype

    html do
      head do
        title { @title }
      end

      body { yield }
    end
  end
end
