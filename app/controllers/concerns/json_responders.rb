# frozen_string_literal: true

# TODO: integrate serializers for all renders
module JsonResponders
  def render_error(message, code = 400, data = {}, serializer = nil, serializer_options = {})
    render(json: {
             code: code,
             message: message,
             data: serialize(data, serializer, serializer_options)
           }, status: code)
  end

  def render_exception(error, ecode = '')
    if error.is_a?(Rack::Timeout::RequestTimeoutException) || error.is_a?(Rack::Timeout::RequestExpiryError)
      render_error('Time Out Error', 503)
    elsif error.is_a?(BadRequestError)
      render_bad_request(error.message)
    else
      render_error("Something went wrong. please try again (#{ecode})")
    end
  end

  def render_bad_request(message, data = {})
    render(json: { code: 400, message: message, data: data }, status: 400)
  end

  def render_not_found(message, data = {})
    render(json: { code: 404, message: message, data: data }, status: 404)
  end

  def render_unauthorized(message)
    render(json: { code: 401, message: message }, status: :unauthorized)
  end

  def render_success(message, data = {}, serializer = nil, serializer_options = {}, extra_info = nil)
    render(json: render_success_payload(message, data, serializer, serializer_options, extra_info), status: 200)
  end

  def render_success_with_websocket(message, data = {}, serializer = nil, serializer_options = {}, method = nil,
                                    record = nil)
    serialized_data = serialize(data, serializer, serializer_options)
    BroadcastService.new(method: method, record: record || data, serialized_data: serialized_data || data,
                         serializer: serializer, serializer_options: serializer_options, use_worker: false).perform
    render(json: { code: 200, message: message, data: serialized_data }, status: 200)
  end

  def render_success_paginated(data = {}, serializer = nil, serializer_options = {}, extra_info = nil)
    render(json: json_payload(data, serializer, serializer_options, extra_info), status: 200)
  end

  def render_updated(message, data = {})
    render(json: { code: 200, message: message, data: data }, status: 200)
  end

  def render_created(message, data = {}, serializer = nil, serializer_options = {})
    render(json: {
             code: 201,
             message: message,
             data: serialize(data, serializer, serializer_options)
           }, status: 201)
  end

  def render_accepted(message, data = {})
    render(json: { code: 202, message: message, data: data }, status: 202)
  end

  private

  def serialize(data = {}, serializer, serializer_options)
    return data if serializer.nil?

    if data.is_a?(Hash)
      data
    elsif data.is_a?(Enumerable)
      ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer, **serializer_options).as_json
    else
      serializer.new(data).as_json
    end
  end

  def json_payload(data, serializer, serializer_options, extra_info)
    payload = {
      code: 200,
      data: serialize(data, serializer, serializer_options),
      pagination: pagination(data)
    }
    payload[:extra] = extra_info if extra_info.present?
    payload
  end

  def render_success_payload(message, data, serializer, serializer_options, extra_info)
    payload = { code: 200, message: message, data: serialize(data, serializer, serializer_options) }
    payload.merge!(extra_info) if extra_info.present?
    payload
  end
end
