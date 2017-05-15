require "kemal"
require "json"
require "./models/*"

ACCESS_TOKEN = ENV["ACCESS_TOKEN"]

# filters
before_all do |env|
  env.response.content_type = "application/json"
end

before_all "/authors" do |env|
  headers = env.request.headers
  if headers.has_key?("token")
    env.response.status_code = 403 unless ACCESS_TOKEN == headers["token"]
  else
    env.response.status_code = 403
  end
end

# actions
post "/authors" do |env|
  Author.all.to_json
end

post "/author" do |env|
  unless env.params.query.has_key?("email")
    env.redirect "/error"
  else
    count, first_name, last_name = Author.find_by(
      "email", env.params.query["email"]
    )

    {
      email:      env.params.query["email"],
      first_name: first_name,
      last_name:  last_name,
      status:     count > 0,
    }.to_json
  end
end

error 403 do
  {error: 403, message: "Invalid Access Token!"}.to_json
end

get "/error" do
  {error: 403, message: "email not found"}.to_json
end

Kemal.run
