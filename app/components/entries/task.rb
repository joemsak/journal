class Components::Entries::Task < Components::Base
  attr_reader :entry, :task

  def initialize(task:)
    @task = task
    @entry = task.entry
  end

  def view_template
    div(data: {
      controller: :task,
      task_entry_date_value: entry.to_param,
      task_task_id_value: task.id
    }) do
      div(
        contenteditable: true,
        data: {
          task_target: :title,
          action: %(
            blur->task#saveTitle
            keydown.enter->task#blurTitle:prevent
            keydown.esc->task#blurTitle
          ).squish
        },
        class: "font-bold text-lg md:text-xl"
      ) { task.title }

      Tabs do
        TabsList do
          TabsTrigger(
            value: "notes",
            class: "cursor-pointer transition-colors hover:text-black"
          ) { "Notes" }

          TabsTrigger(
            value: "challenges",
            class: "cursor-pointer transition-colors hover:text-black"
          ) { "Challenges" }

          TabsTrigger(
            value: "successes",
            class: "cursor-pointer transition-colors hover:text-black"
          ) { "Successes" }

          TabsTrigger(
            value: "improvements",
            class: "cursor-pointer transition-colors hover:text-black"
          ) { "Improvements" }

          TabsTrigger(
            value: "next_steps",
            class: "cursor-pointer transition-colors hover:text-black"
          ) { "Next steps" }
        end

        TabsContent(value: "notes") do
          render Components::TipTap::Editor.new(
            resource: task,
            attribute: :notes,
            path: entry_path(entry),
            method: :patch,
            data: { task_target: :editor }
          )
        end

        TabsContent(value: "challenges") do
          render Components::TipTap::Editor.new(
            resource: task,
            attribute: :challenges,
            path: entry_path(entry),
            method: :patch,
            data: { task_target: :editor }
          )
        end

        TabsContent(value: "successes") do
          render Components::TipTap::Editor.new(
            resource: task,
            attribute: :successes,
            path: entry_path(entry),
            method: :patch,
            data: { task_target: :editor }
          )
        end

        TabsContent(value: "improvements") do
          render Components::TipTap::Editor.new(
            resource: task,
            attribute: :improvements,
            path: entry_path(entry),
            method: :patch,
            data: { task_target: :editor }
          )
        end

        TabsContent(value: "next_steps") do
          render Components::TipTap::Editor.new(
            resource: task,
            attribute: :nextSteps,
            path: entry_path(entry),
            method: :patch,
            data: { task_target: :editor }
          )
        end
      end
    end
  end
end
