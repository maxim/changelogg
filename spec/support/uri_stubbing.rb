module UriStubbing
  def stub_uri(uri, response_body)
    response = Typhoeus::Response.new :code => 200, :body => response_body
    Typhoeus::Request.stub(:get, uri).and_return(response)
  end
end