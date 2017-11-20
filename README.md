# BackBooks Rails API

This is the companion API for the BackBooks live-code from the first week of our Backbone curriculum.

## Installation

```
git clone <whatever>
cd backbone-rails-api
bundle install
rails db:create
rails db:migrate
rails db:seed
```

## Running the Server

```
rails server
```

## Regarding CORS

This API assumes you're running our standard Webpack3 setup, which will run a server on localhost port 8080. If that's not true, you'll need to go into `config/initializers/cors.rb` and change the line `origins locahost:8080` to whatever suits your fancy.
