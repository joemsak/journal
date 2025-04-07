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
    render Views::Contents::New.new(contents:, content:)
  end

  def create
    content.update!(body:)
    head :ok
  end

  def show
    content = content_source.find(params.expect(:id))
    render Views::Contents::Show.new(contents:, content:)
  end

  private

  def contents
    Content.order(entry_date: :desc)
  end

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
