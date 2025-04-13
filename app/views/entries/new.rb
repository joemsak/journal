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
        ButtonTo(
          variant: :outline,
          path: task_forms_path,
          method: :post,
          params: { entry_date: entry.to_param },
          form: { data: { turbo_frame: :tasks_frame } }
        ) { "&plus; Add task".html_safe }

        turbo_frame_tag(:tasks_frame, data: { entry_target: :taskList }) do
          entry.tasks.each do |task|
            div(class: "mt-4") do
              render Components::Entries::Task.new(task:)
            end
          end
        end
      end
    end
  end
end
