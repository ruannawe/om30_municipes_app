class CitizensController < ApplicationController
  def index
    cp = citizen_params
    @citizens = Citizen.filter(cp)
    address_params = cp[:address_attributes]

    if address_params.present?
      @citizens = @citizens.joins(:address).merge(Address.filter(address_params))
    else
      @citizens = @citizens.includes(:address)
    end
  end

  def new
    @citizen = Citizen.new
    @citizen.build_address
  end

  def edit
    @citizen = Citizen.find(params[:id])
    @citizen.build_address unless @citizen.address
  end

  def create
    @citizen = Citizen.new(citizen_params)

    if @citizen.save
      redirect_to citizens_path, notice: 'Citizen was successfully created.'
    else
      flash.now[:alert] = "Failed to create citizen."
      render :new
    end
  end

  def update
    @citizen = Citizen.find(params[:id])

    if @citizen.update(citizen_params)
      redirect_to citizens_path, notice: 'Citizen was successfully updated.'
    else
      flash.now[:alert] = "Failed to update citizen."
      render :edit
    end
  end

  private

  def citizen_params
    return ActionController::Parameters.new if !params[:citizen].present?

    params
          .require(:citizen)
          .permit(
            :full_name,
            :tax_id,
            :national_health_card,
            :email,
            :birthdate,
            :phone,
            :status,
            address_attributes: [
              :id,
              :zip_code,
              :street,
              :neighborhood,
              :city,
              :state,
              :ibge_code
            ]
          )
  end
end
