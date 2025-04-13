# frozen_string_literal: true

class Views::Entries::Show < Views::Base
  include Phlex::Rails::Helpers::LinkTo

  attr_reader :entries, :entry

  def initialize(entries:, entry:)
    @entries = entries
    @entry = entry
    @title = "Entry for #{entry.list_item_name}"
  end

  def view_template
    Layout(title: @title, entries:) do
      div(class: "flex items-center gap-4") do
        h1(class: "font-bold text-xl md:text-2xl") { @title }

        link_to("edit", edit_entry_path(entry), class: "text-blue-900 hover:underline")
      end

      link_to(
        "&larr; today's entry".html_safe,
        root_path,
        class: "text-blue-900 hover:underline"
      )

      if entry.body.present?
        div(class: "mt-4 pt-4 rounded border-t border-gray-300 wrap-break-word") do
          Rinku.auto_link(
            entry.body,
            :all,
            "class='text-blue-600 hover:underline' target='_blank'"
          ).html_safe
        end
      end

      entry.tasks.each do |task|
        div(class: "mt-4 pt-4 rounded border-t border-gray-300 wrap-break-word") do
          h2(class: "font-bold text-lg md:text-xl") { task.title }

          if task.notes.present?
            h3(class: "font-bold") { "Notes" }

            div(class: "mt-4") do
              Rinku.auto_link(
                task.notes,
                :all,
                "class='text-blue-600 hover:underline' target='_blank'"
              ).html_safe
            end
          end

          if task.challenges.present?
            h3(class: "font-bold") { "Challenges" }

            div(class: "mt-4") do
              Rinku.auto_link(
                task.challenges,
                :all,
                "class='text-blue-600 hover:underline' target='_blank'"
              ).html_safe
            end
          end

          if task.successes.present?
            h3(class: "font-bold") { "Successes" }

            div(class: "mt-4") do
              Rinku.auto_link(
                task.successes,
                :all,
                "class='text-blue-600 hover:underline' target='_blank'"
              ).html_safe
            end
          end

          if task.improvements.present?
            h3(class: "font-bold") { "Improvements next time" }

            div(class: "mt-4") do
              Rinku.auto_link(
                task.improvements,
                :all,
                "class='text-blue-600 hover:underline' target='_blank'"
              ).html_safe
            end
          end

          if task.next_steps.present?
            h3(class: "font-bold") { "Next steps" }

            div(class: "mt-4") do
              Rinku.auto_link(
                task.next_steps,
                :all,
                "class='text-blue-600 hover:underline' target='_blank'"
              ).html_safe
            end
          end
        end
      end
    end
  end
end
