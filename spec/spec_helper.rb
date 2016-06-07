$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'promoter'

require 'webmock/rspec'

def promoter()
  Promoter::Client.new('ribeyeeulorem')
end

def fixture(filename)
  File.read("#{File.dirname(__FILE__)}/fixtures/#{filename}")
end

def stub_get_request(url, json_file)
  stub_request(:get, url).
       to_return(status: 200, body: fixture(json_file))
end

