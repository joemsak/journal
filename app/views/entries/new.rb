# frozen_string_literal: true

class Views::Entries::New < Views::Base
  include Phlex::Rails::Helpers::ButtonTo
  include Phlex::Rails::Helpers::TurboFrameTag
  include Phlex::Rails::Helpers::TurboStream

  attr_reader :entries, :entry

  def initialize(entries:, entry:)
    @entries = entries
    @entry = entry
  end

  def view_template
    Layout(title: "Today's Entry", entries:) do
      h1(class: "font-bold text-xl md:text-2xl") { "Daily Technical Journal" }
      p(class: "mt-4") { "Today's entry:" }

      div(data: { controller: :entry }, class: "mt-4") do
        button_to(
          "&plus; Add task".html_safe,
          entry_task_forms_path(entry),
          method: :post,
          class: "px-4 py-2 outline cursor-pointer flex gap-1 items-center",
          form: { data: { turbo_frame: :tasks_frame } }
        )

        turbo_frame_tag(:tasks_frame, data: { entry_target: :taskList }) do
          entry.tasks.each do |task|
            div(class: "mt-4") do
              render Components::Entries::Task.new(entry:, task:)
            end
          end
        end
      end
    end
  end
end
