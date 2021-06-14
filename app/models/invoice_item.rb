# app/models/invoice_items

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: [:pending, :packaged, :shipped]
  has_many :bulk_discounts, through: :merchant

  def applicable_discount
    bulk_discounts = item.merchant.bulk_discounts
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