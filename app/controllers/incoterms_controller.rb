# frozen_string_literal: true

class IncotermsController < ApplicationController
  # GET /incoterms or /incoterms.json
  def index
    @incoterms = Incoterm.all
  end
end
