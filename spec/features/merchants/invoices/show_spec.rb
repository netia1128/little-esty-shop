# spec/features/merchants/invoices/show_spec

require 'rails_helper'

RSpec.describe 'Merchant invoice show page' do 
  describe 'display' do
    it 'shows invoice and its attributes' do
      invoice = Invoice.find(29)

      visit '/merchants/1/invoices/29'
 
      expect(page).to have_content("INVOICE # 29")
      expect(page).to have_content("cancelled")
      expect(page).to have_content("Sunday, March 25, 2012")
      expect(page).to have_content("Parker Daugherty")
    end

    it 'lists all items and item attributes on the invoice' do
      invoice = Invoice.find(29)
      invoice_items = invoice.invoice_items

      visit '/merchants/1/invoices/29'

      invoice_items.each do |invoice_item|
        expect(page).to have_content(invoice_item.item.name)
        expect(page).to have_content(invoice_item.quantity)
        expect(page).to have_content((invoice_item.discounted_unit_price.to_f / 100).round(2))
        expect(page).to have_content(invoice_item.status)
      end
    end

    it 'can update items status through dropdown list' do
      visit '/merchants/1/invoices/29'

      expect(page).to have_button("Save")
      
      within first('.status-update') do
        expect(page).to have_content("packaged")

        select "shipped"
        click_on "Save"
      end

      expect(page).to have_content("shipped")
      expect(current_path).to eq('/merchants/1/invoices/29')
    end

    it 'lists both total discounted and total undiscounted revenue for the invoice' do 
      visit '/merchants/1/invoices/29'
      
      expect(page).to have_content('Undiscounted Total Revenue: $12,817.94')
      expect(page).to have_content('Discounted Total Revenue: $11,997.79')
    end

    it 'contains a link to applied discounts where applicable' do 
      visit '/merchants/1/invoices/29'
      
      within "#invoice-items-133" do
        expect(page).to have_content('See Applied Discount')

        click_on 'See Applied Discount'

        expect(current_path).to eq('/merchants/1/bulk_discounts/1')
      end

      visit '/merchants/1/invoices/29'

      within "#invoice-items-134" do
        expect(page).to have_content('None')
      end

      visit '/merchants/1/invoices/29'
      
      within "#invoice-items-135" do
        expect(page).to have_content('See Applied Discount')

        click_on 'See Applied Discount'

        expect(current_path).to eq('/merchants/1/bulk_discounts/2')
      end
    end
  end
end