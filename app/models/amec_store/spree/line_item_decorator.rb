module AmecStore::Spree
  module LineItemDecorator
    def self.prepended(base)
      base.class_eval do
      end
    end

    def copy_price
      if variant
        update_price if price.nil? || quantity_changed?
        self.cost_price = variant.cost_price if cost_price.nil?
        self.currency = variant.currency if currency.nil?
      end
    end

    def update_price(order_item_count = nil)
      total_count = order_item_count || order_latest_total_count
      variant_price = variant.price_by_count(total_count, order.currency)

      self.price = if variant_price.amount.present?
                     variant_price.price_including_vat_for(tax_zone: tax_zone)
                   else
                     0
                   end
    end

    def order_latest_total_count
      others_quantity = ::Spree::LineItem.where(order_id: order_id).where.not(id: id).sum(:quantity)
      others_quantity + quantity
    end
  end
end

::Spree::LineItem.prepend AmecStore::Spree::LineItemDecorator
