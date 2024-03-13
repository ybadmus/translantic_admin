# frozen_string_literal: true

class ShipmentsController < ApplicationController
  before_action :set_shipment, only: %i[show edit update destroy itenary pdf]

  # GET /shipments or /shipments.json
  def index
    @shipments = ShippingDetail.includes(:location, :receiver, :shipper, :audits, :departure, :destination, :shipping_information).all
  end

  # GET /shipments/1 or /shipments/1.json
  def show; end

  # GET /shipments/1/itenary or /shipments/1/itenary.json
  def itenary
    @audits = @shipment.audits
  end

  # GET /shipments/new
  def new
    @shipment = ShippingDetail.new
    @shipment.build_shipping_information
    @shipment.build_shipper
    @shipment.build_receiver
    @shipment.build_departure
    @shipment.build_destination
    @shipment.build_location
  end

  # GET /shipments/1/edit
  def edit; end

  # GET /shipments/1/pdf
  def pdf
    render_pdf
  end

  # POST /shipments or /shipments.json
  def create
    service = CreateShipmentService.new(params: shipment_params)
    service.perform

    @shipment = service.shipment

    respond_to do |format|
      if service.errors.blank?
        format.html { redirect_to shipment_url(service.shipment), notice: 'Shipment was successfully created.' }
        format.json { render :show, status: :created, location: service.shipment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipments/1 or /shipments/1.json
  def update
    service = UpdateShipmentService.new(shipment: @shipment, params: shipment_params)
    service.perform

    respond_to do |format|
      if service.errors.blank?
        format.html { redirect_to shipment_url(service.shipment), notice: 'Shipment was successfully updated.' }
        format.json { render :show, status: :ok, location: service.shipment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipments/1 or /shipments/1.json
  def destroy
    @shipment.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@shipment)}_row") }
      format.html { redirect_to shipments_url, notice: 'Shipment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_shipment
    @shipment = ShippingDetail.includes(:location, :receiver, :shipper, :audits, :departure, :destination, :shipping_information).find(params[:id])
  end

  def shipment_params
    params.require(:shipment).permit(:frieght_type, :height, :length, :width, :description, :status, :weight, :quantity, :dutiable, :declared_value, :incoterm_id, :tracking_number, :incoterm_id, departure_attributes: %i[city country], destination_attributes: %i[city country], shipper_attributes: %i[name email phone], receiver_attributes: %i[name email phone], shipping_information_attributes: %i[company_name address_line1 address_line2], location_attributes: %i[city country])
  end

  def render_pdf
    render(template: 'shipments/pdf', pdf: 'invoice', page_size: 'A4', margin: { bottom: 22 }, footer: { html: { template: 'pdf_document_footer' } })
  end
end
