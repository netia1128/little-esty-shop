require 'rails_helper'

RSpec.describe 'show page' do

  describe 'page functionality' do
    it 'shows me the discount and item quantity for a particular discount' do
      visit '/merchants/1/bulk_discounts/1'

      expect(find_field('Discount').value).to eq('5%')
      expect(find_field('Item quantity').value).to eq('5')
      expect(page).to_not have_content('Save changes')
    end
  end
end