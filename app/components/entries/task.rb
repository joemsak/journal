class Components::Entries::Task < Components::Base
  attr_reader :entry, :task

  def initialize(entry:, task:)
    @entry = entry
    @task = task
  end

  def view_template
    div(data: { controller: :task }) do
      div(
        contenteditable: true,
        data: { task_target: :title },
        class: "font-bold text-lg md:text-xl"
      ) do
        task.title
      end

      button(
        data: { action: "task#toggleNotes", task_target: :notesBtn },
        class: "px-4 py-2 outline cursor-pointer flex gap-1 items-center"
      ) { "&plus; Show notes".html_safe }

      div(class: :hidden, data: { task_target: :notes }) do
        render Components::TipTap::Editor.new(
          resource: task,
          attribute: :notes,
          path: entry_path(entry),
          method: :patch,
        )
      end
    end
  end
end
