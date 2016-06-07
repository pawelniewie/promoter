require 'promoter/base_client'

module Promoter

  class ContactList
    attr_reader :id, :name

    def initialize(attrs)
      @id = attrs['id']
      @name = attrs['name']
    end
  end

  class ContactListClient < BaseClient

    API_URL =  "https://app.promoter.io/api/lists"

    def model_class
      ContactList
    end

    def all(page=1)
      response = @request.get("#{API_URL}/?page=#{page}")
      response['results'].map {|attrs| from_api attrs}
    end

    def contact_ids_for(contact_list_id)
      response = @request.get("#{API_URL}/#{contact_list_id}/contacts")
      response['results'].map {|attrs| attrs["id"]}
    end

    def remove_contact(params={})
      contact_list_id = params[:contact_list_id]
      contact_id = params[:contact_id]
      contact_email = params[:email]

      if contact_list_id
        if contact_id
          @request.delete("#{API_URL}/#{contact_list_id}/contacts/#{contact_id}")
        elsif contact_email
          @request.post("#{API_URL}/#{contact_list_id}/remove/", {email: contact_email})
        else
          raise "Not enough information provided to remove a contact"
        end
      elsif contact_email
          @request.post("#{API_URL}/remove/", {email: contact_email})
      else
        raise "Not enough information provided to remove a contact"
      end
    end

    # Campaign Params
    # Parameter                   Optional?  Description
    # name                        no         The name of the campaign
    def create(attributes)
      from_api @request.post(API_URL + "/", attributes)
    end

  end
end