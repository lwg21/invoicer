class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @client = @invoice.client
    @invoice_item = InvoiceItem.new
  end

  # def new
  #   @invoice = Invoice.new
  #   @clients = Client.all
  # end

  # def create
  #   @invoice = Invoice.new(invoice_params)
  #   @invoice.company = Current.user.company
  #   if @invoice.save
  #     redirect_to invoice_path(@invoice)
  #   else
  #     raise
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def issue
    @invoice = Invoice.find(params[:id])
    @invoice.issue!
    redirect_to invoice_path(@invoice)
  end

  private

  def invoice_params
    params.require(:invoice).permit(:number, :date, :client_id)
  end
end
