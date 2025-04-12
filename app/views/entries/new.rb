# frozen_string_literal: true

class Views::Entries::New < Views::Base
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
        button(
          data: { action: "entry#addTask", entry_target: :addTaskBtn },
          class: "px-4 py-2 outline cursor-pointer flex gap-1 items-center"
        ) { "&plus; Add task".html_safe }

        (entry.tasks.presence || [entry.tasks.build]).each do |task|
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
