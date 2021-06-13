require 'rails_helper'

RSpec.describe 'new page' do

  describe 'page functionality' do
    it 'allows me to add a new discount for a merchant and redirects me to the merchant discount index page' do
      visit '/merchants/1/bulk_discounts/new'

      fill_in "Discount",	with: "50" 
      fill_in "Item quantity",	with: "90"
      
      click_on 'Save changes'

      expect(current_path).to eq('/merchants/1/bulk_discounts')

      within ".merchant-discount-index > tr:nth-child(5)" do
        expect(page).to have_content('50%')
        expect(page).to have_content('90')
      end
    end
  end
end