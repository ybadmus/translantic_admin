class ShipmentsController < ApplicationController
  before_action :set_shipment, only: %i[ show edit update destroy itenary ]
  before_action :init_dependencies, only: :create

  # GET /shipments or /shipments.json
  def index
    @shipments = ShippingDetail.all
  end

  # GET /shipments/1 or /shipments/1.json
  def show
  end

  def itenary
    #binding.break
  end

  # GET /shipments/new
  def new
    @shipment = ShippingDetail.new
    @shipment.build_shipping_information
    @shipment.build_shipper
    @shipment.build_departure
    @shipment.build_destination
    @shipment.build_location
  end

  # GET /shipments/1/edit
  def edit
  end

  # POST /shipments or /shipments.json
  def create
    @shipment = ShippingDetail.new(shipment_params_hash)

    respond_to do |format|
      if @shipment.save
        format.html { redirect_to shipment_url(@shipment), notice: "Shipment was successfully created." }
        format.json { render :show, status: :created, location: @shipment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipments/1 or /shipments/1.json
  def update
    @shipment.location_id = Location.find_or_create_by(city: shipment_params[:location_city]).id
    destination = Location.find_or_create_by(city: shipment_params[:destination_city])
    destination.update({ country: shipment_params[:destination_country] }) unless shipment_params[:destination_country].blank?
    @shipment.destination_id = destination.id

    respond_to do |format|
      if @shipment.update(shipment_params)
        format.html { redirect_to shipment_url(@shipment), notice: "Shipment was successfully updated." }
        format.json { render :show, status: :ok, location: @shipment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipments/1 or /shipments/1.json
  def destroy
    @shipment.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@shipment)}_row") }
      format.html { redirect_to shipments_url, notice: "Shipment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipment
      @shipment = ShippingDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shipment_params
      params.require(:shipment).permit(:frieght_type, :height, :length, :width, :description, :status, :weight, :quantity, :dutiable, :declared_value, :incoterm_id, :tracking_number, :incoterm_id, :location_city, :destination_city, :destination_country, departure_attributes: %i[id city country], shipper_attributes: %i[id name email phone], receiver_attributes: %i[id name email phone], shipping_information_attributes: %i[id company_name address_line1 address_line2])
    end

    def init_dependencies
      @departure_id = Location.find_or_create_by(city: shipment_params[:departure_attributes][:city]).id
      @shipper_id = Shipper.find_or_create_by(email: shipment_params[:shipper_attributes][:email]).id
      @destination = Location.find_or_create_by(city: shipment_params[:destination_city]).id
      @destination.update({ country: shipment_params[:destination_country] }) unless shipment_params[:destination_country].blank?
      @receiver_id = Receiver.find_or_create_by(email: shipment_params[:receiver_attributes][:email]).id
    end

    def shipment_params_hash
      shipment_params_hash = shipment_params.to_h
      shipment_params_hash[:shipper_id] = @shipper_id
      shipment_params_hash[:shipper_attributes][:id] = @shipper_id
      shipment_params_hash[:departure_id] = @departure_id
      shipment_params_hash[:departure_attributes][:id] = @departure_id
      shipment_params_hash[:destination_id] = @destination.id
      shipment_params_hash[:receiver_id] = @receiver_id
      shipment_params_hash[:receiver_attributes][:id] = @receiver_id
      shipment_params_hash
    end
end
