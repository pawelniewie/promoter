module Promoter
  class BaseClient
    attr_reader :request
    attr_reader :client

    def initialize(client)
      @client = client
      @request = client.request
    end

    def model_class
      raise NotImplementedError
    end

    def from_api(attrs)
      model_class.new(attrs)
    end
  end
end