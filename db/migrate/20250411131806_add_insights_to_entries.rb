class AddInsightsToEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :entries, :insights, :text
  end
end
