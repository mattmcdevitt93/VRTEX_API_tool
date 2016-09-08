class ContactsController < ApplicationController
  before_action :admin_check, only: [:create, :destroy]
  before_action :set_timesheet, only: [:destroy]


  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to dashboard_path, notice: 'Contact was successfully created.' }
        # format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Contact was successfully destroyed.' }
    end
  end

  private

    def set_timesheet
      @contact = Contact.find(params[:id])
    end


  def contact_params
    params.require(:contact).permit(:name, :standing, :notes, :expire?)
  end
end