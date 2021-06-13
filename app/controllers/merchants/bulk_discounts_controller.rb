class Merchants::BulkDiscountsController < ApplicationController

    def index 
        @merchant = Merchant.find(params[:merchant_id])
        @discounts = @merchant.bulk_discounts
        @next_three_holidays = NagerData.new.next_three_holidays
    end

    def show
        @discount = BulkDiscount.find(params[:id])
    end
  end