class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  layout false

  private

  def params
    super.deep_transform_keys!(&:underscore)
  end
end
