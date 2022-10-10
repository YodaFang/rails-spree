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
  end
end

::Spree::Order.prepend AmecStore::Spree::OrderDecorator if ::Spree::Order.included_modules.exclude?(AmecStore::Spree::OrderDecorator)
