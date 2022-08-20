class AddPositionToPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_prices, :position, :integer
    add_index :spree_prices, :position
  end
end
