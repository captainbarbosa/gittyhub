require "rubygems"
require "bundler/setup"
require "sinatra"
require "json"
require "pry"
require "./github"
require 'date'

get "/lookup" do
  render_template("views/home.html.erb")
end

post "/lookup" do
  username_uri = URI("https://api.github.com/users/#{params[:username]}")
  repos_uri = URI("https://api.github.com/users/#{params[:username]}/repos")

  user = GithubClient.new(username_uri, :get)
  repos = GithubClient.new(repos_uri, :get)

  @user = JSON.parse(user.body)
  @repos = JSON.parse(repos.body)

  render_template("views/profile.html.erb")
end

def render_template(template_path)
  template = ERB.new(File.read(template_path))
  template.result(binding)
end
