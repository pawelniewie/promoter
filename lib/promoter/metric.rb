require 'promoter/base_client'

module Promoter

  class Metric

    attr_accessor :campaign_name, :nps, :organization_nps

    def initialize(attrs)
      @campaign_name = attrs["campaign"]
      @nps = attrs["nps"].to_f
      @organization_nps = attrs["organization_nps"].to_f
    end
  end

  class MetricClient < BaseClient

    API_URL = "https://app.promoter.io/api/metrics"

    def model_class
      Metric
    end

    def all
      response = @request.get("#{API_URL}/")
      response['results'].map {|attrs| from_api attrs}
    end

  end
end