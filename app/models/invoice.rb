# app/models/invoice

class Invoice < ApplicationRecord
  enum status: [ 'in progress', :completed, :cancelled ] # 0 => in progress, 1 => completed, etc 
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy

  def self.filter_by_unshipped_order_by_age
    joins(:invoice_items)
    .distinct.select("invoices.id, invoices.created_at")
    .where.not(invoice_items: {status: 'shipped'})
    .order(:created_at)
  end

  def statuses
    ['in progress', 'completed', 'cancelled']
  end

  def undiscounted_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def discounted_revenue
    invoice_items.sum do |invoice_item|
      invoice_item.discounted_unit_price * invoice_item.quantity
    end
  end 
end
