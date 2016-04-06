require "./tests/test_helper"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_lookup_page_returns_content
    response = get "/lookup"

    assert response.ok?
    assert_equal false, response.body.empty?
  end

  def test_github_api_returns_username
    uri = URI("https://api.github.com/users/captainbarbosa")
    person = GithubClient.new(uri, :get)
    person = JSON.parse(person.body)
    username = person["login"]

    assert_equal false, username.empty?
  end

  def test_github_api_returns_users_repos
    uri = URI("https://api.github.com/users/captainbarbosa/repos")
    repos = GithubClient.new(uri, :get)
    repos = JSON.parse(repos.body)

    assert_equal true, repos.is_a?(Array)
  end
end
