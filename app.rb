require "rubygems"
require "bundler/setup"
require "sinatra"
require "json"

get "/" do
  "I am Groot"
end

post "/employees" do
  payload = JSON.parse(request.body.read)

  # [418, payload.to_json]
  payload.to_json
end
