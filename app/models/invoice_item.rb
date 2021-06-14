# app/models/invoice_items

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: [:pending, :packaged, :shipped]
  delegate :merchant, to: :item, allow_nil: true
  delegate :bulk_discounts, to: :merchant, allow_nil: true

  def applicable_discount
    all_discounts = bulk_discounts.where("bulk_discounts.item_quantity <= #{self.quantity}")
    all_discounts.max_by do |discount|
      discount.item_quantity
    end
  end

  def discounted_unit_price
    if applicable_discount.nil?
      unit_price
    else
      unit_price * (1 - ( applicable_discount.discount.to_f / 100 ))
    end
  end
end