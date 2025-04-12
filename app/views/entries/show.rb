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

      div(class: "mt-4 pt-4 rounded border-t border-gray-300 wrap-break-word") do
        Rinku.auto_link(
          entry.body || entry.tasks.last.notes,
          :all,
          "class='text-blue-600 hover:underline' target='_blank'"
        ).html_safe
      end
    end
  end
end
