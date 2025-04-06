class WelcomeController < ApplicationController
  def show
    render Views::Welcome::Show.new
  end
end
