# app/models/invoice_items

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: [:pending, :packaged, :shipped]
  delegate :merchant, to: :item, allow_nil: true
  delegate :bulk_discounts, to: :merchant, allow_nil: true

  def discounted_unit_price
    discount_to_apply = self.bulk_discounts.where("bulk_discounts.item_quantity <= #{self.quantity}").min
    if discount_to_apply.nil?
      unit_price
    else
      unit_price * (1 - ( discount_to_apply.discount.to_f / 100 ))
    end
  end
end