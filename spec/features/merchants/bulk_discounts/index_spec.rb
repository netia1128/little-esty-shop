require 'rails_helper'

RSpec.describe 'index page' do

  describe 'page appearance' do
    it 'shows all of the discounts for the specified merchant including the related item quantity' do
      visit "/merchants/1/bulk_discounts"

      expect(page).to have_content('Discount ID')
      expect(page).to have_content('Discount')
      expect(page).to have_content('Item Quantity')

      within ".merchant-discount-index > tr:nth-child(2)" do
        expect(page).to have_content('1')
        expect(page).to have_content('5%')
        expect(page).to have_content('5')
      end

      within ".merchant-discount-index > tr:nth-child(3)" do
        expect(page).to have_content('2')
        expect(page).to have_content('10%')
        expect(page).to have_content('10')
      end

      within ".merchant-discount-index > tr:nth-child(4)" do
        expect(page).to have_content('3')
        expect(page).to have_content('15%')
        expect(page).to have_content('15')
      end
    end
  end
  describe 'page functionality' do
    it 'each discount id is a link to its show page' do
      visit "/merchants/1/bulk_discounts"

      click_link '1'

      expect(current_path).to eq("/merchants/1/bulk_discounts/1")
    end
  end
end
 