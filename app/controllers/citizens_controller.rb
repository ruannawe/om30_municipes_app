class CitizensController < ApplicationController
  before_action :set_citizen, only: [:edit, :update]

  def index
    @citizens = Citizen.filter(search_params[:citizen])
    @citizens = if search_params[:address].present?
                  @citizens.joins(:address).merge(Address.filter(search_params[:address]))
                else
                  @citizens.includes(:address)
                end
  end

  def new
    @citizen = Citizen.new
    @citizen.build_address
  end

  def edit; end

  def create
    @citizen = Citizen.new(citizen_params)

    if @citizen.save
      CitizenMailer.welcome_email(@citizen).deliver_later
      TwilioService.send_sms(to: @citizen.phone, template_key: :welcome)

      redirect_to citizens_path, notice: 'Citizen was successfully created.'
    else
      flash.now[:alert] = @citizen.errors.full_messages
      respond_to do |format|
        format.turbo_stream
        format.html { render :new }
      end
    end
  end

  def update
    if @citizen.update(citizen_params)
      CitizenMailer.update_email(@citizen).deliver_later
      TwilioService.send_sms(to: @citizen.phone, template_key: :update)

      redirect_to citizens_path, notice: 'Citizen was successfully updated.'
    else
      flash.now[:alert] = @citizen.errors.full_messages
      respond_to do |format|
        format.turbo_stream
        format.html { render :new }
      end
    end
  end

  private

  def set_citizen
    @citizen = Citizen.find(params[:id])
    @citizen.build_address unless @citizen.address
  end

  def citizen_params
    params.fetch(:citizen, {}).permit(citizen_attributes, address_attributes: address_attributes)
  end

  def search_params
    {
      citizen: params.permit(citizen_attributes).reject_blanks,
      address: params.permit(address_attributes).reject_blanks
    }
  end

  def citizen_attributes
    [
      :full_name,
      :tax_id,
      :national_health_card,
      :email,
      :birthdate,
      :phone,
      :status
    ]
  end

  def address_attributes
    [
      :id,
      :zip_code,
      :street,
      :neighborhood,
      :city,
      :state,
      :ibge_code
    ]
  end
end
