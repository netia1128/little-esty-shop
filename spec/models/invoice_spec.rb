require 'rails_helper'

RSpec.describe Invoice do
  before(:each) do
    
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many :transactions}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:merchants).through(:items)}
  end

  describe 'class methods' do
    describe '#filter_by_unshipped_order_by_age' do
      it 'returns all invoices with unshipped items sorted by creation date' do
        expect(Invoice.filter_by_unshipped_order_by_age.count("distinct invoices.id")).to eq(44)
        expect(Invoice.filter_by_unshipped_order_by_age.first.id).to eq(10)
      end
    end
  end

  describe 'instance methods' do
    describe '#stauses' do
      it 'has array of available status options' do
        single_invoice = Invoice.last
        expect(single_invoice.statuses).to eq ['in progress', 'completed', 'cancelled']
      end
    end
    describe '#undiscounted_revenue' do
      it 'calculates total undiscounted revenue' do
        invoice = Invoice.find(29)
        expect(invoice.undiscounted_revenue).to eq(1281794)
      end
    end
    describe '#discounted_revenue' do
      it 'calculates total discounted revenue' do
        invoice = Invoice.find(29)
        expect(invoice.discounted_revenue).to eq(1199778.6)
      end
    end
  end
end
