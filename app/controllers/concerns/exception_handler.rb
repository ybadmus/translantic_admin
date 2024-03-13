# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern
  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :missing_strong_params!
    rescue_from BadRequestError, with: :render_bad_request
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  end

  def record_not_found(exeption)
    render_not_found("Couldn't find #{exeption.model.titleize} with id #{exeption.id}")
  end

  def user_not_authorized
    render_unauthorized('Not Authorized')
  end

  def missing_strong_params!(err)
    render_bad_request(err.message.split("\n")[0])
  end

  def record_invalid(err)
    render_error(err.record.errors.full_messages.to_sentence)
  end
end
