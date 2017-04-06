# NAT

[![Build Status](https://travis-ci.org/timlkelly/nat.svg?branch=master)](https://travis-ci.org/timlkelly/nat)

Nerdery Assessment Test

## Dependencies
- Rails 5.0.2
- Ruby 2.4.1
- PostgreSQL 9.5
- SideKiq
- Redis

## Setup
- `bundle install`
- `bundle exec rake db:create`
- `bundle exec rake db:migrate`
- `bundle exec rake db:test:prepare`
- `./start` use the included [bash script](https://github.com/timlkelly/nat/blob/master/start) to start the development server
- Go to [localhost:5000](http://localhost:5000)

## Testing
Use [guard](https://github.com/guard/guard) to monitor and
automatically run tests.

`bundle exec guard`


