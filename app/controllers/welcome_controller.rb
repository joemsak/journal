class WelcomeController < ApplicationController
  def show
    render Views::Welcome::Show.new(content:)
  end

  private

  def content
    content_record.body
  end

  def content_record
    content_source.find_or_initialize_by(entry_date:)
  end

  def content_source
    Content
  end

  def entry_date
    Date.current
  end
end
