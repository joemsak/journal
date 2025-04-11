# frozen_string_literal: true

class Views::Entries::Edit < Views::Base
  attr_reader :entries, :entry

  def initialize(entries:, entry:)
    @title = "Editing entry for #{entry.list_item_name}"
    @entries = entries
    @entry = entry
  end

  def view_template
    Layout(title: @title, entries:) do
      h1(class: "font-bold text-xl md:text-2xl") { @title }

      render Components::TipTap::Editor.new(entry:)
    end
  end
end
