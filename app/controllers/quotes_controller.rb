# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy pdf]

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.includes(:departure, :destination, :incoterm, :quoter).order(created_at: :desc).all
  end

  # GET /quotes/1 or /quotes/1.json
  def show; end

  # GET /quotes/new
  def new
    @quote = Quote.new
    @quote.build_quoter
    @quote.build_departure
    @quote.build_destination
  end

  # GET /quotes/1/edit
  def edit; end

  # GET /shipments/1/pdf
  def pdf
    render_pdf
  end

  # POST /quotes or /quotes.json
  def create
    service = CreateQuoteService.new(params: quote_params)
    service.perform

    @quote = service.quote

    respond_to do |format|
      if service.errors.blank?
        format.html { redirect_to new_quote_url, notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    service = UpdateQuoteService.new(quote: @quote, params: quote_params)
    service.perform

    @quote = service.quote

    respond_to do |format|
      if service.errors.blank?
        format.html { redirect_to quote_url(@quote), notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@quote)}_row")
      end
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_quote
    @quote = Quote.includes(:departure, :destination, :incoterm, :quoter).find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:frieght_type, :height, :length, :width, :message, :status, :total_gross_weight, :incoterm_id, departure_attributes: %i[city country], destination_attributes: %i[city country], quoter_attributes: %i[name email phone])
  end

  def render_pdf
    render(template: 'quotes/pdf', pdf: 'invoice', page_size: 'A4', margin: { bottom: 22 }, footer: { html: { template: 'pdf_document_footer' } })
  end
end
