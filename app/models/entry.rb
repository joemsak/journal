class Entry < ApplicationRecord
  has_many :tasks, -> { order(created_at: :desc) }

  accepts_nested_attributes_for :tasks

  def week
    entry_date.beginning_of_week
  end

  def to_param
    entry_date.strftime("%Y-%m-%d")
  end

  def list_item_name
    entry_date.strftime("%A %b %-d, %Y")
  end
end
