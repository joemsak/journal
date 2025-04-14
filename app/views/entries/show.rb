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
      h1(class: "font-bold text-xl md:text-2xl") { @title }

      link_to(
        "&larr; today's entry".html_safe,
        root_path,
        class: "text-blue-900 hover:underline"
      )

      entry.tasks.each do |task|
        div(class: "mt-4 wrap-break-word") do
          h1(class: "font-bold text-xl md:text-2xl") { task.title }

          if task.notes.present?
            h2(class: "font-bold text-lg md:text-xl mt-4") { "Notes" }

            div(class: "mt-2") do
              Rinku.auto_link(
                task.notes,
                :all,
                "class='text-blue-600 hover:underline' target='_blank'"
              ).html_safe
            end
          end

          if task.challenges.present?
            h2(class: "font-bold text-lg md:text-xl mt-4") { "Challenges" }

            div(class: "mt-2") do
              Rinku.auto_link(
                task.challenges,
                :all,
                "class='text-blue-600 hover:underline' target='_blank'"
              ).html_safe
            end
          end

          if task.successes.present?
            h2(class: "font-bold text-lg md:text-xl mt-4") { "Successes" }

            div(class: "mt-2") do
              Rinku.auto_link(
                task.successes,
                :all,
                "class='text-blue-600 hover:underline' target='_blank'"
              ).html_safe
            end
          end

          if task.improvements.present?
            h2(class: "font-bold text-lg md:text-xl mt-4") { "Improvements next time" }

            div(class: "mt-2") do
              Rinku.auto_link(
                task.improvements,
                :all,
                "class='text-blue-600 hover:underline' target='_blank'"
              ).html_safe
            end
          end

          if task.next_steps.present?
            h2(class: "font-bold text-lg md:text-xl mt-4") { "Next steps" }

            div(class: "mt-2") do
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
