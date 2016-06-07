require 'promoter/base_client'

module Promoter

  class Feedback

    attr_reader :id, :contact, :score, :score_type, :posted_date, :comment, :follow_up_url, :url

    def initialize(attrs)
      @id = attrs["id"]
      @contact = Contact.new(attrs["contact"])
      @score = attrs["score"]
      @score_type = attrs["score_type"]
      @posted_date = Time.parse(attrs["posted_date"])
      @comment = attrs["comment"]
      @follow_up_url = attrs["followup_href"]
      @follow_up_href = attrs["href"]
    end
  end

  class FeedbackClient < BaseClient

    API_URL =  "https://app.promoter.io/api/feedback"

    def model_class
      Feedback
    end

    # Parameter                 Required Description
    # score	                    false    Filtering by score can be achieved with
    #                                    a range 0-10
    # score_type	              false	   Filtering by score type can be achieved
    #                                    with a list of values promoter,
    #                                    detractor, passive
    # survey__campaign	        false	   Filtering by campaign can be achieved
    #                                    by the given id of your campaign id
    # survey__campaign__status	false	   Filtering by campaign status can be
    #                                    achieved by providing one of the
    #                                    campaign status values: ACTIVE, COMPLETE.
    # NOTE: This url parameter does not require quotes around the value.
    # e.g. (<api-url>?survey__campaign__status=ACTIVE)
    def all(attrs={})
      response = @request.get("#{API_URL}/?#{query_string(attrs)}")
      response['results'].map {|attrs| from_api attrs}
    end

    def find(id)
      from_api @request.get("#{API_URL}/#{id}")
    end

    private

    def query_string(attrs)
      URI.encode_www_form(attrs)
    end

  end
end