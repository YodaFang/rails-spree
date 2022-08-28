module AmecStore::Spree
  module StoreDecorator
    def self.prepended(base)
      base.class_eval do
      end
    end

    def available_stocks
      @available_stocks ||= Spree::StockLocation.active.order(name: :asc)
    end
  end
end

::Spree::Store.prepend AmecStore::Spree::StoreDecorator
