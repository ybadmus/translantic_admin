# frozen_string_literal: true

class InvalidResponseError < StandardError
  def initialize(message = 'Invalid response')
    super(message)
  end
end
