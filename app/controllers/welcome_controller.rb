class WelcomeController < ApplicationController
  def show
    render Views::Welcome::Show.new(content: Content.first&.body)
  end
end
