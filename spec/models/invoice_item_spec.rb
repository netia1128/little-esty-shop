require 'rails_helper'

RSpec.describe InvoiceItem do

  describe 'relationships' do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe 'instance methods' do
    describe '#applicable_discount' do
      it 'determines the discount applicable to an invoice item' do
        invoice_item1 = InvoiceItem.find(133)
        invoice_item2 = InvoiceItem.find(134)
        invoice_item3 = InvoiceItem.find(136)

        expect(invoice_item1.applicable_discount.id).to eq(1)
        expect(invoice_item2.applicable_discount).to eq(nil)
        expect(invoice_item3.applicable_discount.id).to eq(2)
      end
    end 
    describe '#discounted_unit_price' do
      it 'determines the disounted unit price, if any, based on item quantity' do
        invoice_item1 = InvoiceItem.find(133)
        invoice_item2 = InvoiceItem.find(134)
        invoice_item3 = InvoiceItem.find(136)

        expect(invoice_item1.discounted_unit_price.round(0)).to eq(21453)
        expect(invoice_item2.discounted_unit_price.round(0)).to eq(4291)
        expect(invoice_item3.discounted_unit_price.round(0)).to eq(60368)
      end
    end 
  end
end
