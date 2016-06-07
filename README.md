# Promoter

promoter is a wrapper for the promoter.io REST API.

You can find the promoter.io api docs here: http://docs.promoter.apiary.io/

## Installation

First off you need to grab your [promoter.io](http://www.promoter.io) api key.

Add this line to your application's Gemfile:

```ruby
gem 'promoter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install promoter

Set your api key with:
```ruby
promoter = Promoter::Client.new('YOUR API KEY')
```
(Put this into an initializer i.e. ```app/initializers/promoter.rb``` if using Rails.)

## Feedback
### Get all feedback

```ruby
promoter.feedback.all(score: 8) # => returns all feedback with a score of 8
# this is paginated. Pass page: 2 to get the second page
# (I know, this is different from the other api calls! This will be fixed in later versions)
```

Possible filters:
  ```score```                    Filter by the score
  ```score_type```               Filters by the score type: ```promoter```, ```detractor```, ```passive```
  ```survey_campaign```          Filter by the campaign id
  ```survey_campaign_status```   Filter by the campaign status: ```ACTIVE```, ```COMPLETE```

### Get a specific feedback

```ruby
promoter.feedback.find(79) #=> id of the feedback to return
```

## Contacts

### Get all contacts

```ruby
promoter.contact.all(page: 2) # => this is paginated - returns page 2 of results
```

To find the a contact by an email pass in the ```email``` option:
```ruby
promoter.contact.all(email: "chris@lexoo.co.uk")
```

### Get a specific contact

```ruby
promoter.contact.find(897)
```

### Create a contact

```ruby
promoter.contact.create(email: "chris@lexoo.co.uk",    # required
                         first_name: "Chris",           # optional
                         last_name: "O'Sullivan",       # optional
                         contact_list: [599],           # array of contact list ids to add to
                         campaign: 78,                  # campaign which this belongs to
                         attributes: { plan: 'silver' } # any extra data you want to add to the contact
                         send: false )                  # set this to true to send the NPS immediately
```

### Remove a contact

```ruby
promoter.contact.destroy("chris@lexoo.co.uk")
```

### Survey a contact

```ruby
promoter.contact.survey(email: "chris@lexoo.co.uk",    # required
                         first_name: "Chris",           # optional
                         last_name: "O'Sullivan",       # optional
                         campaign: 78,                  # campaign which this belongs to
                         attributes: { plan: 'silver' })# any extra data you want to add to the contact
```

## Campaigns
### Create a campaign

```ruby
promoter.campaign.create(name: "Campaign Name",    # required
                          contact_list: 1,          # required
                          email: 1)                 # required
```

### Get all campaigns

```ruby
promoter.campaign.all(page: 2) # => this is paginated - returns page 2 of results
```

### Send surveys for a campaign

```ruby
promoter.campaign.send_surveys(33, false)
```

This takes two parameters, the campaign id, and a boolean as to send out surveys to ALL of the customers for the campaign. (This is defaulted to false!)

## Contact lists
### Create a contact list

```ruby
promoter.contact_list.create(name: "List Name")    # required
```

### Get all contact lists

```ruby
promoter.contact_list.all(2)  # => this is paginated - returns page 2 of results
```

### Get All Contacts for a Contact List

```ruby
promoter.contact_list.contact_ids_for(2)
# => returns an array of contact ids for a contact list id
```

### Remove a contact from a contact list

```ruby
promoter.contact_list.remove_contact(contact_list_id: 7899,
                                     contact_id: 15777)  
```

### Remove a contact from a contact list by email

```ruby
promoter.contact_list.remove_contact(email: "me@me.com",
                                     contact_id: 15777)  
```

### Remove a contact from all contact lists

```ruby
promoter.contact_list.remove_contact(contact_id: 15777)
```

## Email Templates
### Create an email template

```ruby
promoter.email_template.create(name: "Campaign Name", # required
               subject: "Email Name",                 # required
               logo: "<base64EncodedImageData>",      # required
               reply_to_email: "me@me.com",           # required
               from_name: "Name",                     # required
               intro_message: "Message",              # required
               language: "en",                        # required
               company_brand_product_name: "name")    # required
```

### Get all email templates

```ruby
promoter.email_template.all # => returns all results
```

## Metrics

```ruby
promoter.metric.all
# => returns a list of interesting metrics that promoter has for your account
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/promoter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
