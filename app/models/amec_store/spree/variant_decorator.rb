module AmecStore::Spree
  module VariantDecorator
    def self.prepended(base)
      base.class_eval do
        has_one :default_price,
              -> { with_deleted.where(currency: Spree::Store.default.default_currency, position: 1) },
              class_name: 'Spree::Price',
              dependent: :destroy

        has_one :default_price1,
              -> { with_deleted.where(currency: Spree::Store.default.default_currency, position: 1) },
              class_name: 'Spree::Price',
              dependent: :destroy

        has_one :default_price2,
              -> { with_deleted.where(currency: Spree::Store.default.default_currency, position: 2) },
              class_name: 'Spree::Price',
              dependent: :destroy

        has_one :default_price3,
              -> { with_deleted.where(currency: Spree::Store.default.default_currency, position: 3) },
              class_name: 'Spree::Price',
              dependent: :destroy

        def price
          default_price&.price
        end

        def price1
          default_price1&.price
        end

        def price1=(p)
          find_or_build_default_price1.price = p
        end

        def find_or_build_default_price1
          default_price1 || build_default_price1
        end

        def price2
          default_price2&.price
        end

        def price2=(p)
          find_or_build_default_price2.price = p
        end

        def find_or_build_default_price2
          default_price2 || build_default_price2
        end

        def price3
          default_price3&.price
        end

        def price3=(p)
          find_or_build_default_price3.price = p
        end

        def find_or_build_default_price3
          default_price3 || build_default_price3
        end
      end
    end
  end
end

::Spree::Variant.prepend AmecStore::Spree::VariantDecorator