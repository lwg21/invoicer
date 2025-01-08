class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_item = InvoiceItem.new
  end

  def new
    @invoice = Invoice.new
    @clients = Client.all
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to invoice_path(@invoice)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:number, :date, :client_id)
  end
end
