module AmecStore::Spree
  module OrderDecorator
    def self.prepended(base)
      base.class_eval do
        checkout_flow do
          go_to_state :address
          go_to_state :confirm
          go_to_state :complete
        end
      end
    end
  end
end

::Spree::Order.prepend AmecStore::Spree::OrderDecorator
