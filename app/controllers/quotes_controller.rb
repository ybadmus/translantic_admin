class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :set_quoter, only: :create
  before_action :set_locations, only: %i[ create update ]

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    @quote.build_quoter
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params_hash)
    @quote.departure_id = Location.find_or_create_by(city: quote_params[:departure_city]).id
    @quote.destination_id = Location.find_or_create_by(city: quote_params[:destination_city]).id

    respond_to do |format|
      if @quote.save
        format.html { redirect_to new_quote_url, notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    @quote.departure_id = Location.find_or_create_by(city: quote_params[:departure_city]).id
    @quote.destination_id = Location.find_or_create_by(city: quote_params[:destination_city]).id

    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully updated." }
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
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@quote)}_row") }
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    def set_quoter
      @quoter = Quoter.find_by(email: quote_params[:quoter_attributes][:email])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(:frieght_type, :height, :length, :width, :message, :status, :total_gross_weight, :incoterm_id, :destination_city, :departure_city,  quoter_attributes: %i[id name email phone])
    end

    def quote_params_hash
      quote_params_hash = quote_params.to_h
      quote_params_hash[:quoter_id] = @quoter&.id
      quote_params_hash[:quoter_attributes][:id] = @quoter&.id
      quote_params_hash
    end
end
