module AmecStore::Spree
  module LineItemDecorator
    def self.prepended(base)
      base.class_eval do
      end
    end

    def update_price(order_item_count = nil)
      total_count = order_item_count || order.quantity
      price = variant.price_by_count(total_count, order.currency)

      self.price = if price.amount.present?
                     price.price_including_vat_for(tax_zone: tax_zone)
                   else
                     0
                   end
    end
  end
end

::Spree::LineItem.prepend AmecStore::Spree::LineItemDecorator
