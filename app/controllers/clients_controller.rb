class ClientsController < ApplicationController
  def index
    @clients = Client.all.order(name: :asc)

    #   @clients = Client
    # .joins(:invoices)
    # .select("clients.*, COUNT(invoices.id) AS invoices_count")
    # .group("clients.id")
    # .order("invoices_count DESC")
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      redirect_to params[:back_url].presence || clients_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def invoice
    @client = Client.find(params[:id])
    @invoice = Invoice.new(client: @client, company: Current.user.company)
    if @invoice.save
      redirect_to invoice_path(@invoice)
    else
      redirect_back_or_to clients_path
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :details, :vat_number, :phone_number, :email_address)
  end
end
