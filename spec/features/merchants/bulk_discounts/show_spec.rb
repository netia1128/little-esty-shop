require 'rails_helper'

RSpec.describe 'show page' do

  describe 'page functionality' do
    it 'shows me the discount and item quantity for a particular discount' do
      visit '/merchants/1/bulk_discounts/1'

      expect(page).to have_content('5%')
      expect(page).to have_content('5')
      expect(page).to have_content('Edit Discount')
    end
  end
end