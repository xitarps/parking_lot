# frozen_string_literal: true

before '/*' do
  params = request.body.read
  @params = JSON.parse(params).deep_symbolize_keys unless params.empty?
end

def reply(action)
  status action[:status]
  action[:data]
end
