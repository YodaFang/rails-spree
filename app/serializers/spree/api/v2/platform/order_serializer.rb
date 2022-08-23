module Spree
  module Api
    module V2
      module Platform
        class OrderSerializer < BaseSerializer
          set_type :spree_order

          attributes :number, :item_total, :total, :ship_total, :adjustment_total, :created_at,
                   :updated_at, :completed_at, :included_tax_total, :additional_tax_total, :display_additional_tax_total,
                   :display_included_tax_total, :tax_total, :currency, :state, :token, :email,
                   :display_item_total, :display_ship_total, :display_adjustment_total, :display_tax_total,
                   :promo_total, :display_promo_total, :item_count, :special_instructions, :display_total,
                   :pre_tax_item_amount, :display_pre_tax_item_amount, :pre_tax_total, :display_pre_tax_total,
                   :shipment_state, :payment_state, :public_metadata

          belongs_to :user
          belongs_to :created_by, serializer: Dependencies.platform_admin_user_serializer.constantize
          belongs_to :approver, serializer: Dependencies.platform_admin_user_serializer.constantize
          belongs_to :canceler, serializer: Dependencies.platform_admin_user_serializer.constantize

          belongs_to :bill_address, serializer: AddressSerializer
          belongs_to :ship_address, serializer: AddressSerializer

          has_many :line_items
          has_many :payments
          has_many :shipments

          has_many :state_changes
          has_many :return_authorizations
          has_many :reimbursements
          has_many :adjustments
          has_many :all_adjustments, serializer: :adjustments, type: :adjustment

          has_many :order_promotions
        end
      end
    end
  end
end
