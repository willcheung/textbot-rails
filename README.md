# README

This is a simple textbot to help anyone manage a simple list, such as to-do, grocery, reminders, etc. The bot has two components: API/backend to manage requests, and [Twilio Studio Flow](https://www.twilio.com/docs/studio) to manage the user workflow.

## Prerequisite
* Ruby 2.6.5
* Rails 6.0.2
* Postgres 12
* Twilio SMS phone #

## Gems used (outside of Rails default)
* devise
* twilio-ruby
* annotate (for annotating database schema on model files)

## Setting up locally
* Fill in `config/database.yml`
* Do the usual `rails db:migrate` and `rails s` to get localhost running
* You can test the API endpoints (without Twilio Studio Flow) via [Postman](https://www.postman.com/). Details are in each controller.

*Note that at this point, you won't get an SMS yet. The Flows are the entry points to receive / send SMS.*

### Setting up Twilio Studio Flow with your local Rails server
* Get Twilio auth token and fill in `config/api_keys.yml`
* Setup [ngrok](https://ngrok.com/) so Twilio can talk to your localhost via public internet
* We need to import the Flow (coming soon!)


## Deploying to AWS Elastic Beanstalk
Everything is pre-configured to deploy to EBS. I wrestled a bit because EBS wasn't playing nice with Rails 6 dependencies, but you shouldn't have any issues deploying this repo directly to EBS. Please follow [instructions here](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/ruby-rails-tutorial.html) and a bunch of content [on the web](https://www.google.com/search?q=rails+6+elastic+beanstalk) about how to deploy. 
