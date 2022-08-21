class AddPositionToPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_prices, :position, :integer, default: 9
    add_index :spree_prices, :position
  end
end
