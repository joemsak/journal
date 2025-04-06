class AddEntryDateToContents < ActiveRecord::Migration[8.0]
  def change
    add_column :contents, :entry_date, :date
  end
end
