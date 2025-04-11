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

      render Components::TipTap::Editor.new(entry:)
    end
  end
end
