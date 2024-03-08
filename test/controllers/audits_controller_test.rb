# frozen_string_literal: true

require 'test_helper'

class AuditsControllerTest < ActionDispatch::IntegrationTest
  test 'should get destroy' do
    get audits_destroy_url
    assert_response :success
  end
end
