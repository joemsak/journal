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

  def update
    entry.update(task_params)
    render json: { resourceId: task_id }
  end

  private

  def entries
    Entry.order(entry_date: :desc)
  end

  def task_id
    params.dig(:task, :id) || entry.tasks.pick(:id)
  end

  def entry
    entry_source.find_or_initialize_by(entry_date:)
  end

  def task_params
    { tasks_attributes: [ task_attribute_params ] } if params[:task].present?
  end

  def task_attribute_params
    params.require(:task).permit(
      :id,
      :notes,
      :challenges,
      :successes,
      :improvements,
      :next_steps
    )
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
