class CompaniesController < ApplicationController
  def profile
    @test = "Hello world"
    Rails.logger.info "Hello world"
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      redirect_to params[:back_url].presence || profile_path(@company)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def statistics
    invoices = Current.user.company.invoices
    @total = Invoice.all.map(&:total).sum
  end

  private

  def company_params
    params.require(:company).permit(
      :designation,
      :address_line1,
      :address_line2,
      :city,
      :postal_code,
      :country,
      :vat_number,
      :phone_number,
      :email_address,
      :iban,
      :bic,
      :jurisdiction
    )
  end
end
