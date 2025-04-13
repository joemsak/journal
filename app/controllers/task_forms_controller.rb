class TaskFormsController < ApplicationController
  def create
    respond_to do |format|
      format.turbo_stream do
        render Components::Entries::PrependTaskForm.new(entry:, task:)
      end
    end
  end

  private

  def entry
    @entry ||= entry_source.find_or_initialize_by(entry_date:)
  end

  def task
    entry.tasks.build
  end

  def entry_source
    Entry
  end

  def entry_date
    params[:entry_id] || Date.current
  end
end
