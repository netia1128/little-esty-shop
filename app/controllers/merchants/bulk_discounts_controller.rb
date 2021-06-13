class Merchants::BulkDiscountsController < ApplicationController

    def create
      BulkDiscount.create!(bulk_discount_params)
      redirect_to merchant_bulk_discounts_path
    end

    def destroy
      bulk_discount = BulkDiscount.find(params[:id])
      bulk_discount.destroy
      redirect_to merchant_bulk_discounts_path
    end
    
    def index 
      @merchant = Merchant.find(params[:merchant_id])
      @discounts = @merchant.bulk_discounts
      @next_three_holidays = NagerData.new.next_three_holidays
    end

    def new
      @merchant = Merchant.find(params[:merchant_id])
      @discount = BulkDiscount.new
    end

    def show
      @discount = BulkDiscount.find(params[:id])
    end

    private

    def bulk_discount_params
      @merchant = Merchant.find(params[:merchant_id])
      params.require(:bulk_discount).permit(:discount, :item_quantity, :merchant_id)
    end
  end