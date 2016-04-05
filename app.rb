require "rubygems"
require "bundler/setup"
require "sinatra"
require "json"
require "pry"
require "./github"

get "/" do
  render_template("views/home.html.erb")
end

post "/lookup" do
  uri = URI("https://api.github.com/users/captainbarbosa")
  @person = GithubClient.new(uri, :get)
  @person.body
  render_template("views/profile.html.erb")

end

def render_template(template_path)
  template = ERB.new(File.read(template_path))
  template.result(binding)
end
