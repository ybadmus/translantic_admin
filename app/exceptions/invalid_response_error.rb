# frozen_string_literal: true

class InvalidResponse < StandardError
  def initialize(message = 'Invalid response')
    super(message)
  end
end
