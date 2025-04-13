class TaskFormsController < ApplicationController
  def create
    respond_to do |format|
      format.turbo_stream do
        render Components::Entries::PrependTaskForm.new(task:)
      end
    end
  end

  private

  def task
    entry.tasks.build
  end

  def entry
    entry_source.find_or_initialize_by(entry_date:)
  end

  def entry_source
    Entry
  end

  def entry_date
    params[:entry_date] || Date.current
  end
end
