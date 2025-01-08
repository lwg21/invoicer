class InvoiceItemsController < ApplicationController
  def create
    @invoice = Invoice.find(params[:invoice_id])
    @invoice_item = InvoiceItem.new(invoice_item_params)
    @invoice_item.invoice = @invoice
    if @invoice_item.save
      redirect_to invoice_path(@invoice)
    end
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:date, :name, :quantity, :unit_price)
  end
end
