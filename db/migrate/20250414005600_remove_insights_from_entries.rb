class RemoveInsightsFromEntries < ActiveRecord::Migration[8.0]
  def change
    remove_column :entries, :insights, :text
  end
end
