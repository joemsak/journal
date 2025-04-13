# frozen_string_literal: true

class Views::Entries::Edit < Views::Base
  include Phlex::Rails::Helpers::LinkTo

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
      end

      (entry.tasks.presence || [entry.tasks.build]).each do |task|
        div(class: "mt-4", data: { controller: :task }) do
          h2(class: "font-bold text-lg md:text-xl") { "Task" }

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
  end
end
