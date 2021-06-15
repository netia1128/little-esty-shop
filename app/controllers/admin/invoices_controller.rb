# app/controllers/invoice_controller.rb

class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(invoice_params)
    @invoice_items = @invoice.invoice_items

    render 'show'
  end

  private

  def invoice_params
    params.require(:invoice).permit(:status,
                  :customer_id)
  end
end
