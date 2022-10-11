module AmecStore::Spree
  module OrderDecorator
    def self.prepended(base)
      base.class_eval do
        checkout_flow do
          go_to_state :address
          go_to_state :delivery
          go_to_state :complete
        end
      end
    end

    def create_proposed_shipments
      all_adjustments.shipping.delete_all

      shipment_ids = shipments.map(&:id)
      ::Spree::StateChange.where(stateful_type: 'Spree::Shipment', stateful_id: shipment_ids).delete_all
      ::Spree::ShippingRate.where(shipment_id: shipment_ids).delete_all

      shipments.delete_all

      # Inventory Units which are not associated to any shipment (unshippable)
      # and are not returned or shipped should be deleted
      inventory_units.on_hand_or_backordered.delete_all

      self.shipments = ::AmecStore::Spree::Stock::AmecCoordinator.new(self).shipments
    end
  end
end

::Spree::Order.prepend AmecStore::Spree::OrderDecorator if ::Spree::Order.included_modules.exclude?(AmecStore::Spree::OrderDecorator)
