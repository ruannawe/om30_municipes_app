class CitizensController < ApplicationController
  def index
    @citizens = Citizen.filter(citizen_params)

    if address_params.present?
      @citizens = @citizens.joins(:address).merge(Address.filter(address_params))
    else
      @citizens = @citizens.includes(:address)
    end
  end

  # @citizen.save
  # @address.persisted?
  def create
    @citizen = Citizen.new(citizen_params)

    if @citizen.save
      @address = @citizen.create_address(address_params)
      if @address.persisted?
        redirect_to citizens_path, notice: 'Citizen was successfully created with address.'
      else
        flash.now[:alert] = "Failed to create address: " + @address.errors.full_messages.to_sentence
        render :new
      end
    else
      flash.now[:alert] = "Failed to create citizen: " + @citizen.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def citizen_params
    params_key_as_symbol('citizen')
    byebug
    return ActionController::Parameters.new if params[:citizen].empty?

    params
          &.require(:citizen)
          .permit(:full_name, :tax_id, :national_health_card, :email, :birthdate, :phone, :status)
          .reject { |_key, value| value.blank? }
  end

  def address_params
    params_key_as_symbol('address')
    return ActionController::Parameters.new if params[:address].empty?

    params
          &.require(:address)
          .permit(:zip_code, :street, :neighborhood, :city, :state, :ibge_code)
          .reject { |_key, value| value.blank? }
  end

  def params_key_as_symbol(key)
    if params["[#{key}]"].present?
      params[:"#{key}"] = params["[#{key}]"]
      params.delete("[#{key}]")
    end
  end
end
