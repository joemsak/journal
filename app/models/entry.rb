class Entry < ApplicationRecord
  has_many :tasks

  accepts_nested_attributes_for :tasks

  def to_param
    entry_date.strftime("%Y-%m-%d")
  end

  def list_item_name
    entry_date.strftime("%A %b %-d, %Y")
  end
end
