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

  def show
    entry = entry_source.find_by(finder_params)
    render Views::Entries::Show.new(entries:, entry:)
  end

  def edit
    render Views::Entries::Edit.new(entries:, entry:)
  end

  def update
    resource_id = if entry_params && entry.update(entry_params)
      entry.id
    elsif task_params && entry.update(task_params)
      entry.tasks.order(:created_at).pluck(:id).last
    end

    if resource_id
      render json: { resourceId: resource_id }
    else
      render json: entry.errors, status: :unprocessable_entity
    end
  end

  private

  def entries
    Entry.order(entry_date: :desc)
  end

  def entry
    entry_source.find_or_initialize_by(entry_date:)
  end

  def entry_params
    params[:entry].permit(:body).presence
  end

  def task_params
    if params[:task].present?
      { tasks_attributes: [ params[:task].permit(:id, :notes) ] }
    end
  end

  def entry_source
    Entry
  end

  def entry_date
    params[:entry_date] || Date.current
  end

  def finder_params
    { entry_date: params.expect(:entry_date) }
  end
end
