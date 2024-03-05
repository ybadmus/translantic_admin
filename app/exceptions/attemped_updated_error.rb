# frozen_string_literal: true

class AttempedUpdatedError < StandardError
  def initialize(message = 'Already Updated')
    super(message)
  end
end
