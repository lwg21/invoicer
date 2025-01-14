class InvoicesController < ApplicationController
  def index
    invoices = Current.user.company.invoices
    @drafts = invoices.where(issued: false).order(:created_at)
    @issued_invoices = invoices.where(issued: true).order(:number)
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
