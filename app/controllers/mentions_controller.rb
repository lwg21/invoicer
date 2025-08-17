class MentionsController < ApplicationController
  def create
    @invoice = Invoice.find(params[:invoice_id])
    @mention = Mention.new(text: params[:mention][:text])
    @mention.invoice = @invoice
    @mention.save
    redirect_to invoice_path(@invoice)
  end

  def destroy
    @mention = Mention.find(params[:id])
    @mention.destroy
    redirect_to invoice_path(@mention.invoice), status: :see_other
  end
end
