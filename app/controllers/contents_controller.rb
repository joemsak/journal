class ContentsController < ApplicationController
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
