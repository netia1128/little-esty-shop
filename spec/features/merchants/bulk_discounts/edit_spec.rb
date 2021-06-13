require 'rails_helper'

RSpec.describe 'edit page' do

  describe 'page functionality' do
    it 'allows me to edit a discount and then redirects me to the discounts show page' do
      discount = BulkDiscount.create(discount: 50, item_quantity:90, merchant_id: 1)
      visit "/merchants/1/bulk_discounts/#{discount.id}/edit"

      fill_in "Discount",	with: "500" 
      fill_in "Item quantity",	with: "5000" 

      click_on 'Save changes'

      expect(current_path).to eq("/merchants/1/bulk_discounts/#{discount.id}")
      expect(page).to have_content('500')
      expect(page).to have_content('5000')
    end
  end
end