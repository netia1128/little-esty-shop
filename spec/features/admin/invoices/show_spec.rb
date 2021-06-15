require 'rails_helper'

RSpec.describe 'invoices show page', type: :feature do
  before(:all) do
    @invoice = Invoice.first
    @first_invoice_item = @invoice.invoice_items.first
    @last_invoice_item = @invoice.invoice_items.last
  end

  describe 'page appearance' do
    it 'has all info about that invoice' do
      visit "/admin/invoices/#{@invoice.id}"
      date = @invoice.created_at.strftime("%A, %B %d, %Y")
      expect(page).to have_content @invoice.status.capitalize
      expect(page).to have_content @invoice.id
      expect(page).to have_content date
      expect(page).to have_content @invoice.customer.first_name
      expect(page).to have_content @invoice.customer.last_name
    end

    it 'has information about all of the invoice\'s items' do
      visit "/admin/invoices/#{@invoice.id}"
      first_exp_price = "$#{@first_invoice_item.unit_price / 100.0}"
      last_exp_price = "$#{@last_invoice_item.unit_price / 100.0}"
      expect(page).to have_content @first_invoice_item.item.name
      expect(page).to have_content @first_invoice_item.quantity
      expect(page).to have_content first_exp_price
      expect(page).to have_content @first_invoice_item.status
      expect(page).to have_content @last_invoice_item.item.name
      expect(page).to have_content @last_invoice_item.quantity
      expect(page).to have_content last_exp_price
      expect(page).to have_content @last_invoice_item.status
    end

    it 'lists total discounted and undiscounted revenue from this invoice' do
      visit "/admin/invoices/29"

      expect(page).to have_content('$12,817.94')
      expect(page).to have_content('$11,997.79')
    end
  end

  describe 'page functionality' do
    it 'can update invoice status' do
      visit "/admin/invoices/1"
      expected_status = @invoice.status.capitalize
      expect(page).to have_select('invoice_status', selected: expected_status)
      select 'Completed', from: 'invoice_status' 
      click_button 'Update Invoice'
      expect(current_path).to eq "/admin/invoices/1"
      expect(page).to have_content('Completed')
    end
  end
end
