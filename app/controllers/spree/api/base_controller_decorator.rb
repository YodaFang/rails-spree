module Spree::Api
  module BaseControllerDecorator
    def permitted_line_item_attributes
      super + [:price, :variant_id, :sku, :stock_location_id]
    end
  end
end

::Spree::Api::BaseController.prepend Spree::Api::BaseControllerDecorator if ::Spree::Api::BaseController.included_modules.exclude?(Spree::Api::BaseControllerDecorator)
