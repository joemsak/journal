class EntriesController < ApplicationController
  before_action -> {
    unless session[:authenticated]
      respond_to do |f|
        f.html { redirect_to login_path }
        f.json { render json: { error: "Forbidden" }, status: :forbidden }
      end
    end
  }

  def new
    render Views::Entries::New.new(entries:, entry:)
  end

  def create
    entry.update!(body:)
    head :ok
  end

  def show
    entry = entry_source.find(params.expect(:id))
    render Views::Entries::Show.new(entries:, entry:)
  end

  private

  def entries
    Entry.order(entry_date: :desc)
  end

  def entry
    entry_source.find_or_initialize_by(entry_date:)
  end

  def body
    params.require(:entry).expect(:body)
  end

  def entry_source
    Entry
  end

  def entry_date
    Date.current
  end
end
