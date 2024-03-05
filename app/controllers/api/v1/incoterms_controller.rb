# frozen_string_literal: true

module Api
  module V1
    class IncotermsController < ApiController
      # GET : /api/v1/{incoterms}
      def index
        incoterms = Incoterm.all
        render_success('success', incoterms, IncotermSerializer)
      end
    end
  end
end
