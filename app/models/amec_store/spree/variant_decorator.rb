module AmecStore::Spree
  module VariantDecorator
    def self.prepended(base)
      base.class_eval do
        has_one :default_price,
              -> { where(currency: Spree::Store.default.default_currency, position: 0) },
              class_name: 'Spree::Price',
              dependent: :destroy
        has_one :default_price1,
              -> { where(currency: Spree::Store.default.default_currency, position: 1) },
              class_name: 'Spree::Price',
              dependent: :destroy
        has_one :default_price2,
              -> { where(currency: Spree::Store.default.default_currency, position: 2) },
              class_name: 'Spree::Price',
              dependent: :destroy
        has_one :default_price3,
              -> { where(currency: Spree::Store.default.default_currency, position: 3) },
              class_name: 'Spree::Price',
              dependent: :destroy
        has_many :prices,
              -> { order position: :asc },
              class_name: 'Spree::Price',
              dependent: :destroy,
              inverse_of: :variant
      end
    end

    def price1=(p)
      find_or_build_default_price1.amount = p if p.present?
    end

    def find_or_build_default_price1
      default_price1 || build_default_price1
    end

    def price2=(p)
      find_or_build_default_price2.amount = p if p.present?
    end

    def find_or_build_default_price2
      default_price2 || build_default_price2
    end

    def price3=(p)
      find_or_build_default_price3.amount = p if p.present?
    end

    def find_or_build_default_price3
      default_price3 || build_default_price3
    end

    def price_by_count(count, currency = nil)
      if count.blank? || count < 100
        return default_price1 || default_price
      elsif count >= 200
        return default_price3 || default_price2 || default_price1 || default_price
      else
        return default_price2 || default_price1 || default_price
      end
    end
  end
end

::Spree::Variant.prepend AmecStore::Spree::VariantDecorator if ::Spree::Variant.included_modules.exclude?(AmecStore::Spree::VariantDecorator)