class InvoiceItemsController < ApplicationController
  def create
    @invoice = Invoice.find(params[:invoice_id])
    @invoice_item = InvoiceItem.new(invoice_item_params)
    @invoice_item.invoice = @invoice
    if @invoice_item.save
      redirect_to invoice_path(@invoice)
    end
  end

  def destroy
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.destroy
    redirect_to invoice_path(@invoice_item.invoice)
  end

  def duplicate
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.dup.save
    redirect_to invoice_path(@invoice_item.invoice)
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:date, :name, :quantity, :unit_price)
  end
end
