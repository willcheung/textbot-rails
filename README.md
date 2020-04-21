# Textbot for managing to-do lists

This is a simple textbot to help anyone manage a simple list, such as to-do, grocery, reminders, etc. This was built for a Twilio Hackathon, and you can read the [story behind it](https://dev.to/willcheung/twilio-hackathon-shared-to-do-grocery-lists-between-friends-family-and-businesses-343a). The bot has two components: API/backend to manage requests, and [Twilio Studio Flow](https://www.twilio.com/docs/studio) to manage the user workflow.

<img src="https://res.cloudinary.com/practicaldev/image/fetch/s--rW-Nf-Dk--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/9nstfu9ci1c9701fke9k.png" alt="textbot-screenshot" width="600"/>

## Live Demo
Text "hi" to 616.344.5566

## Prerequisite
* Ruby 2.6.5
* Rails 6.0.2
* Postgres 12
* Twilio SMS phone #

## Gems used (outside of Rails default)
* devise
* twilio-ruby
* annotate (for annotating database schema on model files)

## Setting up Rails app locally
* Fill in `config/database.yml`
* Do the usual `rails db:migrate` and `rails s` to get `http://localhost:3000` running
* You can test the API endpoints (without Twilio Studio Flow) via [Postman](https://www.postman.com/). The endpoints are:

```
GET  /api/users/retrieve/:phone
POST /api/users/sign_up
GET  /api/lists/show_items/:phone
POST /api/lists/add_item
POST /api/lists/remove_item
```
The JSON structure of `POST` endpoints are in corresponding controllers. An example from Postman:
<img src="https://dev-to-uploads.s3.amazonaws.com/i/r3goztj0mkwyabzszlw7.png" alt="textbot-postman" width="500"/>

*Note 1: In screenshot, I'm using ngrok URL, described below.*

*Note 2: At this point, you won't get an SMS yet. The Studio Flows handles most of receiving / sending SMS.*

### Setting up Twilio Studio Flow with your local Rails server
* Get Twilio auth token and fill in `config/api_keys.yml`
* Setup [ngrok](https://ngrok.com/) so Twilio can talk to your localhost via public internet
* Inside `vendor/twilio/` directory, there are four JSON files. Inside these JSON files, replace all `yourapp.com` with ngrok's URL.
* Go to Twilio Studio and import the flow using those JSONs. Twilio account identifiers are removed, but they're automatically filled in when you import from your Twilio account.
<img src="https://twilio-cms-prod.s3.amazonaws.com/images/newflowfromjson.width-1600.png" alt="flow-import" width="500"/>

* After import, find your Flow SIDs on Studio dashboard. Replace the dummy SIDs in file `/app/controllers/commands_controller.rb` where there's `FWxxxxxxxxxx-action-item`.
<img src="https://dev-to-uploads.s3.amazonaws.com/i/izkczfb1nnx7xxm9bdyk.png" alt="Studio Flow sids" width="500"/>

* Finally, configure the Triggers & Sign Up Flow with your Twilio phone #.
<img src="https://dev-to-uploads.s3.amazonaws.com/i/yyn4ft6bme5znyk873jh.png" alt="SMS Flow" width="500"/>

And you're good to go! Text "hi" to your Twilio phone # and watch your ngrok / Rails console.


## Deploying to AWS Elastic Beanstalk
Everything is pre-configured to deploy to EBS. I wrestled a bit because EBS wasn't playing nice with Rails 6 dependencies, but you shouldn't have any issues deploying this repo directly to EBS. Please follow [instructions here](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/ruby-rails-tutorial.html) and a bunch of content [on the web](https://www.google.com/search?q=rails+6+elastic+beanstalk) about how to deploy.

EBS is nice because it provides health monitoring, auto-scaling, pre-configured security settings, and manages all the microservices in one place. However, Rails 6 is relatively new and I suspect the environment wasn't properly testing to deploy Rails 6 app out of the box. Either way, you have the option to deploy in container if you feel more comfortable.

## License
[MIT](https://opensource.org/licenses/mit-license.html)
