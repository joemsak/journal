class RenameContentsToEntries < ActiveRecord::Migration[8.0]
  def change
    rename_table :contents, :entries
  end
end
