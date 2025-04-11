class Entry < ApplicationRecord
  has_many :tasks

  def to_param
    entry_date.strftime("%Y-%m-%d")
  end

  def list_item_name
    entry_date.strftime("%A %b %-d, %Y")
  end
end
