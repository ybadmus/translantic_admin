# frozen_string_literal: true

class BadRequestError < StandardError
  def initialize(message = 'Some parameters are missing')
    super(message)
  end
end
