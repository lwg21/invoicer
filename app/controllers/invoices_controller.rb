class InvoicesController < ApplicationController
  def index
    invoices = Current.user.company.invoices
    @drafts = invoices.where(issued: false).order(created_at: :desc)
    @issued_invoices = invoices.where(issued: true).order(number: :desc)
  end

  def show
    @invoice = Invoice.find(params[:id])
    @client = @invoice.client
    if params[:edit_item]
      @invoice_item = InvoiceItem.find(params[:edit_item])
    else
      @invoice_item = InvoiceItem.new
    end
  end

  def issue
    invoice = Invoice.find(params[:id])
    invoice.issue!
    redirect_to invoice_path(invoice)
  end

  def pay
    invoice = Invoice.find(params[:id])
    invoice.update(paid: true) if invoice.issued?
    redirect_to invoices_path
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    redirect_to invoices_path, notice: "Invoice was successfully destroyed."
  end

  private

  def invoice_params
    params.require(:invoice).permit(:number, :date, :client_id)
  end
end
