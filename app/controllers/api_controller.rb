# frozen_string_literal: true

class ApiController < ActionController::API
  include ExceptionHandler
  include JsonResponders
  include MissingData
end
