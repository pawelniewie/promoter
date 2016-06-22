require 'httparty'
require 'json'

module Promoter

  class Request

    include HTTParty
    include Errors

    def initialize(client)
      @client = client

      default_options.update({headers: auth_header})
    end

    def get(url)
      response = self.class.get(url)
      parse_response(response)
    end

    def post(url, params)
      response_format = params.delete(:response_format) || :json
      response = self.class.post(url, body: params.to_json)
      parse_response(response, response_format)
    end

    def delete(url)
      response = self.class.delete(url)
      parse_response(response)
    end

    private

    def parse_response(response, response_format=:json)
      check_for_error(response.response.code)
      display_debug(response.body)
      if response_format == :json
        JSON.parse(response.body.to_s)
      else
        response.body.to_s
      end
    end

    def display_debug(response)
      if @client.debug
        puts "-" * 20 + " DEBUG " + "-" * 20
        puts response
        puts "-" * 18 + " END DEBUG " + "-" * 18
      end
    end

    def auth_header
      if @client.api_key.nil?
        raise Errors::Unauthorized.new("You need to set your promoter api key. You can register for a Promoter API key with a Promoter.io Account.")
      end
      { "Authorization" => "Token #{@client.api_key}",
        'Content-Type' => 'application/json' }
    end

  end

end