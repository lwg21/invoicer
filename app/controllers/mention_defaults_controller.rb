class MentionDefaultsController < ApplicationController
  def create
    @company = Company.find(params[:company_id])
    @mention_default = MentionDefault.new(text: params[:mention_default][:text])
    @mention_default.company = @company
    @mention_default.save
    redirect_to edit_company_path(@company)
  end

  def update
    @mention_default = MentionDefault.find(params[:id])
    case params[:commit]
    when "edit"
      @mention_default.update(text: params[:mention_default][:text])
      flash[:notice] = "Saved"
    when "cancel"
      flash[:notice] = "Canceled"
    when "destroy"
      @mention_default.destroy
      flash[:notice] = "Deleted"
    end
    redirect_to edit_company_path(@mention_default.company)
  end
end
