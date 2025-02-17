# README

This application is a full-stack web app which has integration with StarsWar API to search and get resources. Currently, the application has support for `movies` and `characters`.


### Tech Stack

The application is developed using Ruby on Rails with React using [Inertia](https://inertia-rails.dev/).

The application uses cache to avoid making same requests to fetch resource again. Right now the expiry of cache is 12 hours.
### Local Setup

The application setup is tested via docker on Macbook M1. In order to run the application locally please make sure to install Docker version 20+ on your machine.

Run the following command:
```
docker compose up
```

It will start web server and background job server. Visit http://localhost:3000

### Specs

To run specs, run the following command.

```
bundle exec rspec
```
You will need to setup Ruby and install dependencies for running specs locally.
