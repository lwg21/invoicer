class ClientsController < ApplicationController
  def index
    @clients = Client.all
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
      redirect_to clients_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.require(:client).permit(:designation, :address_line1, :address_line2, :city, :postal_code, :country, :vat_number, :phone_number, :email_address)
  end
end
