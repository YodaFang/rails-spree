module ApplicationHelper
  def available_stocks
    current_store.available_stocks
  end

  def get_stock_name stock_id
    stock = current_store.available_stocks&.find { |s| s.id == stock_id }
    stock&.name
  end

  def line_items_to_stock_map line_items
    line_items.inject({}) do |rst, item |
      if items = rst[item.stock_location_id]
        items << item
      else
        rst[item.stock_location_id] = [item]
      end
      rst
    end
  end
end
