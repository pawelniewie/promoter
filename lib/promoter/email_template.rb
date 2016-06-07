require 'promoter/base_client'

module Promoter
  class EmailTemplate

    attr_reader :id, :name, :logo, :subject, :reply_to_email, :from_name,
                :intro_message, :language, :company_brand_product_name

    def initialize(attrs)
      @id = attrs["id"]
      @name = attrs["name"]
      @logo = attrs["logo"]
      @subject = attrs["subject"]
      @reply_to_email = attrs["reply_to_email"]
      @from_name = attrs["from_name"]
      @intro_message = attrs["intro_message"]
      @language = attrs["language"]
      @company_brand_product_name = attrs["company_brand_product_name"]
    end
  end

  class EmailTemplateClient < BaseClient

    API_URL =  "https://app.promoter.io/api/email"


    def model_class
      EmailTemplate
    end

    def all(page=1)
      response = @request.get("#{API_URL}/?page=#{page}")
      response['results'].map {|attrs| from_api attrs}
    end

    # Email Template Params
    # Parameter                   Optional?  Description
    # name                        no         The name of the email template
    # subject                     no         The subject line of the email template
    # logo                        no         Base64 encoded image data (only) representing
    #                                        the logo with your survey. It is also the logo 
    #                                        they see when they respond to the survey with a score. 
    #                                        The logo will be located at the top of the survey
    # reply_to_email              no         The reply-to email address for the email template
    # from_name                   no         The name the template is showing to be from
    # intro_message               no         This is the message that appears just above 
    #                                        the 0-10 scale and below the logo
    # language                    no         The language the template is in
    # company_brand_product_name  no         The name inserted into the main question
    def create(attributes)
      from_api @request.post(API_URL + "/", attributes)
    end

  end
end
