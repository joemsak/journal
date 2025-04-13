class TasksController < ApplicationController
  def update
    if task.update(title:)
      render json: { taskId: task.id }
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  private

  def task
    @task ||= entry.tasks.find_by(id: task_id) || entry.tasks.build
  end

  def task_id
    task_params[:id]
  end

  def entry
    entry_source.find_or_initialize_by(entry_date:)
  end

  def title
    task_params.expect(:title)
  end

  def task_params
    params.require(:task).permit(:id, :title)
  end

  def entry_source
    Entry
  end

  def entry_date
    params[:entry_date] || Date.current
  end
end
