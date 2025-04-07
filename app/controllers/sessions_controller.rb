class SessionsController < ApplicationController
  def new
    render Views::Sessions::New.new
  end

  def create
    if valid_password?
      session[:authenticated] = true
      redirect_to root_path
    else
      render Views::Sessions::New.new, status: :forbidden
    end
  end

  private

  def valid_password?
    system_password == params.expect(:password)
  end

  def system_password
    BCrypt::Password.new(Rails.application.credentials.password_digest)
  end
end
