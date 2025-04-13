# frozen_string_literal: true

class Views::Entries::Edit < Views::Base
  include Phlex::Rails::Helpers::ButtonTo
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::TurboFrameTag
  include Phlex::Rails::Helpers::TurboStream

  attr_reader :entries, :entry

  def initialize(entries:, entry:)
    @title = "Editing entry for #{entry.list_item_name}"
    @entries = entries
    @entry = entry
  end

  def view_template
    Layout(title: @title, entries:) do
      h1(class: "font-bold text-xl md:text-2xl") { @title }

      link_to("&larr; back".html_safe, entry, class: "text-blue-900 hover:underline")

      div(data: { controller: :entry }, class: "mt-4") do
        button(
          data: { action: "entry#toggleBody", entry_target: :bodyBtn },
          class: "px-4 py-2 outline cursor-pointer flex gap-1 items-center"
        ) { "&plus; Show body".html_safe }

        div(data: { entry_target: :body }, class: "hidden") do
          render Components::TipTap::Editor.new(
            resource: entry,
            attribute: :body,
            path: entry_path(entry),
            method: :patch,
          )
        end

        button_to(
          "&plus; Add task".html_safe,
          entry_task_forms_path(entry),
          method: :post,
          class: "mt-4 px-4 py-2 outline cursor-pointer flex gap-1 items-center",
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
