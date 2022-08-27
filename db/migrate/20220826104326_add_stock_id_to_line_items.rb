class AddStockIdToLineItems < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_line_items, :stock_location_id, :bigint
  end
end
