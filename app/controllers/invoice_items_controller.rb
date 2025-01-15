class InvoiceItemsController < ApplicationController
  def create
    @invoice = Invoice.find(params[:invoice_id])
    @invoice_item = InvoiceItem.new(invoice_item_params)
    @invoice_item.invoice = @invoice
    if @invoice_item.save
      redirect_to invoice_path(@invoice)
    end
  end

  def update
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.update(invoice_item_params)
    redirect_to invoice_path(@invoice_item.invoice)
  end

  def destroy
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.destroy
    redirect_to invoice_path(@invoice_item.invoice)
  end

  def duplicate
    original_item = InvoiceItem.find(params[:id])
    duplicate_item = original_item.dup
    InvoiceItem.where(invoice: original_item.invoice)
               .where("position > ?", original_item.position)
               .update_all("position = position + 1")
    duplicate_item.position = original_item.position + 1
    duplicate_item.save
    redirect_to invoice_path(original_item.invoice)
  end

  def move
    invoice_item = InvoiceItem.find(params[:id])
    target_position = case params[:direction]
    when "up" then invoice_item.position - 1
    when "down" then invoice_item.position + 1
    end

    swap_item = invoice_item.invoice.invoice_items.find_by(position: target_position)
    return unless swap_item

    InvoiceItem.transaction do
      swap_item.update!(position: invoice_item.position)
      invoice_item.update!(position: target_position)
    end

    redirect_to invoice_path(invoice_item.invoice)
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:date, :name, :quantity, :unit_price)
  end
end
