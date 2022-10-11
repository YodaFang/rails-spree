module AmecStore::Spree
  module Stock
    class AmecCoordinator
      attr_reader   :order, :inventory_units
      attr_accessor :unallocated_inventory_units

      def initialize(order, inventory_units = nil)
        @order = order
        @inventory_units = inventory_units || ::Spree::Stock::InventoryUnitBuilder.new(order).units
      end

      def shipments
        packages.map do |package|
          package.to_shipment.tap { |s| s.address_id = order.ship_address_id }
        end
      end

      def packages
        packages = build_packages
        packages = estimate_packages(packages)
      end

      def build_packages(packages = [])
        stock_locations_from_line_items.each do |stock_location|
          packer = build_packer(stock_location, inventory_units)
          packages += packer.packages
        end

        packages
      end

      private

      def stock_locations_from_line_items
        ::Spree::StockLocation.active.joins(:stock_items).where(id: order.line_items.map(&:stock_location_id)).distinct
      end

      def estimate_packages(packages)
        estimator = ::Spree::Stock::Estimator.new(order)
        packages.each do |package|
          package.shipping_rates = estimator.shipping_rates(package)
        end
        packages
      end

      def build_packer(stock_location, inventory_units)
        ::Spree::Stock::Packer.new(stock_location, inventory_units, splitters(stock_location))
      end

      def splitters(_stock_location)
        # extension point to return custom splitters for a location
        Rails.application.config.spree.stock_splitters
      end
    end
  end
end
