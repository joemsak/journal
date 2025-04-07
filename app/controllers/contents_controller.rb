class ContentsController < ApplicationController
  before_action -> {
    unless session[:authenticated]
      respond_to do |f|
        f.html { redirect_to login_path }
        f.json { render json: { error: "Forbidden" }, status: :forbidden }
      end
    end
  }

  def new
    render Views::Contents::New.new(content:)
  end

  def create
    content.update!(body:)
    head :ok
  end

  private

  def content
    content_source.find_or_initialize_by(entry_date:)
  end

  def body
    params.expect(:content)
  end

  def content_source
    Content
  end

  def entry_date
    Date.current
  end
end
