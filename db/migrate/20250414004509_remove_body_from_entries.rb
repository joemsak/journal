class RemoveBodyFromEntries < ActiveRecord::Migration[8.0]
  def change
    remove_column :entries, :body, :text
  end
end
