class GithubClient
  attr_reader :uri, :verb, :data
  def initialize(uri, verb, data = {})
    @uri = uri
    @verb = verb
    @data = data

    # Build client
    @http = Net::HTTP.new(uri.host, uri.port)
    @http.use_ssl = true
    @http.set_debug_output($stdout)
    build_request
  end

  def response
    @response ||= @http.request(@request)
  end

  def body
    # Request response becomes a Ruby object
    response.body
  end

  private

  def build_request
    if verb == :get
      @request = Net::HTTP::Get.new(uri.request_uri)
    elsif verb == :patch
      @request = Net::HTTP::Patch.new(uri.request_uri)
      @request.body = data.to_json
    end
    @request.basic_auth(ENV['GITHUB_USER'], ENV['GITHUB_PASSWORD'])
  end
end
