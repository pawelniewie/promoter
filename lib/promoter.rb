require "promoter/version"
require "promoter/errors"
require "promoter/request"
require "promoter/campaign"
require "promoter/email_template"
require "promoter/contact"
require "promoter/contact_list"
require "promoter/feedback"
require "promoter/metric"

module Promoter
  class Client
    attr_reader :api_key
    attr_reader :debug
    attr_reader :request

    def initialize(api_key, debug = false)
      @api_key = api_key
      @debug = debug
      @request = Request.new(self)
    end

    def campaign()
      CampaignClient.new(self)
    end

    def contact()
      ContactClient.new(self)
    end
  end
end
