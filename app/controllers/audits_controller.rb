# frozen_string_literal: true

class AuditsController < ApplicationController
  before_action :set_audit, only: %i[destroy]

  # DELETE /audits/1 or /audits/1.json
  def destroy
    @audit.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@audit)}_row") }
      format.html { redirect_to shipments_url, notice: 'Audit was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_audit
    @audit = Audited::Audit.find(params[:id])
  end
end
