class ApiController < ActionController::API
  include ExceptionHandler
  include JsonResponders
  include MissingData
end
