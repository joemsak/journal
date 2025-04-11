class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :entry, null: false, foreign_key: true
      t.text :challenges
      t.text :successes
      t.text :improvements
      t.text :next_steps

      t.timestamps
    end
  end
end
