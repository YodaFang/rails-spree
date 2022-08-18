module AmecStore::Spree
  module OrderDecorator
    def self.prepended(base)
      base.class_eval do
        checkout_flow do
          go_to_state :address
          go_to_state :confirm, if: ->(order) { order.confirmation_required? }
          go_to_state :complete
          remove_transition from: :delivery, to: :confirm, unless: ->(order) { order.confirmation_required? }
        end
      end
    end
  end
end

::Spree::Order.prepend AmecStore::Spree::OrderDecorator
