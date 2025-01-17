require 'rails_helper'

RSpec.describe 'index page' do

  describe 'page appearance' do
    it 'shows all of the discounts for the specified merchant including the related item quantity and a removal link' do
      visit "/merchants/1/bulk_discounts"

      expect(page).to have_content('Discount ID')
      expect(page).to have_content('Discount')
      expect(page).to have_content('Item Quantity')
      expect(page).to have_content('Remove')

      within "#merchant-discount-index-1" do
        expect(page).to have_content('1')
        expect(page).to have_content('5%')
        expect(page).to have_content('5')
        expect(page).to have_content('Remove')
      end

      within "#merchant-discount-index-2" do
        expect(page).to have_content('2')
        expect(page).to have_content('10%')
        expect(page).to have_content('10')
        expect(page).to have_content('Remove')
      end

      within "#merchant-discount-index-3" do
        expect(page).to have_content('3')
        expect(page).to have_content('15%')
        expect(page).to have_content('15')
        expect(page).to have_content('Remove')
      end

      expect(page).to_not have_content('50%')
      expect(page).to_not have_content('90')
    end
    it 'shows the next three US public holiday names' do
      mock_data = '[{"name":"Hannukah"},
                   {"name":"Dragon Boat Festival"},
                   {"name":"Kwanza"}]'
      allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(double("response", status: 200, body: mock_data))
      
      visit "/merchants/1/bulk_discounts"

      expect(page).to have_content('Upcoming Holidays')
      expect(page).to have_content('Hannukah')
      expect(page).to have_content('Dragon Boat Festival')
      expect(page).to have_content('Kwanza')
    end
  end
  describe 'page functionality' do
    it 'each discount id is a link to its show page' do
      visit "/merchants/1/bulk_discounts"

      click_link '1'

      expect(current_path).to eq("/merchants/1/bulk_discounts/1")
    end
    it 'contains a button that takes you to a page to create a new discount' do
      visit '/merchants/1/bulk_discounts'

      expect(page).to have_link('Add New Discount')

      click_link 'Add New Discount'

      expect(current_path).to eq('/merchants/1/bulk_discounts/new')
    end
    it 'allows me to remove discounts' do
      visit '/merchants/1/bulk_discounts'
      end
  end
end
 