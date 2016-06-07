module Promoter

  class Contact
    attr_reader :id, :email, :first_name, :last_name, :created_date, :attributes

    def initialize(attrs)
      @id = attrs['id']
      @email = attrs['email']
      @first_name = attrs['first_name']
      @last_name = attrs['last_name']
      @created_date = Time.parse(attrs['created_date']) if attrs['created_date']
      @attributes = attrs['attributes']
    end

  end

  class ContactClient
    API_URL = 'https://app.promoter.io/api/contacts'

    def initialize(client)
      @request = client.request
    end

    # Parameter     Optional?  Description
    # page	        yes	       Returns which page of results to return.
    #                          Defaults to 1
    # email         yes        Filter the results by email address.
    def all(options={})
      if !options.is_a?(Hash)
        puts '-- DEPRECATION WARNING--'
        puts "Passing in a number as a page is deprecated and will be removed from future versions of this gem.\nInstead pass in a hash of attributes.\n\n e.g. Promoter::Contact.all(page: 2)"
        query_string = "page=#{options}"
      else
        # default to first page
        options[:page] ||= 1
        query_string = URI.encode_www_form(options)
      end
      response = @request.get("#{API_URL}/?#{query_string}")
      response['results'].map {|attrs| Contact.new(attrs)}
    end

    def find(id)
      response = @request.get("#{API_URL}/#{id}")
      Contact.new(response)
    end

    def destroy(email)
      attributes = {
        email: email
      }
      response = @request.post("#{API_URL}/remove/", attributes)
      Contact.new(response)
    end

    # Contact Params
    # Parameter     Optional?  Description
    # email         no	       The email of the contact to add to the organization.
    # first_name	  yes	       The first name of the contact to add to the organization.
    # last_name	    yes	       The last name of the contact to add to the organization.
    # contact_list	yes	       A list of Contact List Id’s to associate a contact to.
    #                          If one is not provided the contact will be
    #                          associated to a default generated contact list.
    # attributes	  yes	       A dictionary of key value pairs of custom
    #                          attributes that will be associated with the
    #                          contact and contact list.
    # send	        yes	       A boolean value set to true in order to express
    #                          intent to survey this contact for a given campaign.
    # campaign	    yes	       The campaign id you would like to associate the
    #                          contact to. Note: Campaign must have a contact
    #                          list associated to it in order for the contact to
    #                          be added correctly. Otherwise, the contact will
    #                          be associated to a default generated contact list
    #                          for your given organization.
    def create(attributes)
      response = @request.post(API_URL + '/', attributes)
      Contact.new(response)
    end

    def survey(attributes)
      response = @request.post(API_URL + '/survey/', attributes)
      Contact.new(response)
    end

  end
end