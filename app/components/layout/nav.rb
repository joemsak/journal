class Components::Layout::Nav < Components::Base
  include Phlex::Rails::Helpers::LinkTo

  attr_reader :items

  def initialize(items:)
    @items = items
  end

  def view_template
    nav do
      h2(class: "font-bold text-lg md:text-xl") { "Previous entries" }

      items.map do |item|
        link_to(
          item.list_item_name,
          item,
          class: "block mt-4 first:m-0 text-blue-900 hover:underline"
        )
      end
    end
  end
end
