class Components::Layout::Nav < Components::Base
  include Phlex::Rails::Helpers::LinkTo

  attr_reader :items

  def initialize(items:)
    @items = items
  end

  def view_template
    nav do
      h2(class: "font-bold text-lg md:text-xl") { "Previous entries" }

      div(class: "w-full") do
        Accordion do
          items.group_by(&:week).map do |week, items|
            if current_week?(week)
              p(class: "font-medium mt-4 mb-2") { "This week" }
              div { links_to_items(items) }
            else
              AccordionItem(open: current_week?(week)) do
                AccordionTrigger(class: "cursor-pointer") do
                  p(class: "font-medium") { week.strftime('%B %-d') }
                  AccordionIcon()
                end

                AccordionContent do
                  links_to_items(items)
                end
              end
            end
          end
        end
      end
    end
  end

  private

  def current_week?(week)
    week == Time.current.beginning_of_week.to_date
  end

  def links_to_items(items)
    items.each do |item|
      link_to(
        item.list_item_name,
        item,
        class: "block mt-4 first:m-0 last:mb-4 text-blue-900 hover:underline"
      )
    end
  end
end
