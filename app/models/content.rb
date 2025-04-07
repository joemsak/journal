class Content < ApplicationRecord
  def list_item_name
    entry_date.strftime("%A %b %-d, %Y")
  end
end
