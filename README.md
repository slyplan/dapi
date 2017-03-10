# Gett challenge app

## About the application

To build API used [JSON:API](http://jsonapi.org/) specification

Data models stored at `app/models`

## Setting up

Clone repository

```
git clone https://github.com/slyplan/dapi.git
```

Change `config/database.yml` and run the command,
```
rake db:setup
```
It will create the database and load driver and metrics which stored at https://github.com/gtforge/CodeChallenge

*Metrics without specifyed driver will be discarded*

## CRUD

### Get driver

```
driver_metrics GET    /drivers/:driver_id/metrics(.:format)     metrics#index
               POST   /drivers/:driver_id/metrics(.:format)     metrics#create
 driver_metric GET    /drivers/:driver_id/metrics/:id(.:format) metrics#show
               PATCH  /drivers/:driver_id/metrics/:id(.:format) metrics#update
               PUT    /drivers/:driver_id/metrics/:id(.:format) metrics#update
               DELETE /drivers/:driver_id/metrics/:id(.:format) metrics#destroy
       drivers POST   /drivers(.:format)                        drivers#create
        driver GET    /drivers/:id(.:format)                    drivers#show
               PATCH  /drivers/:id(.:format)                    drivers#update
               PUT    /drivers/:id(.:format)                    drivers#update
               DELETE /drivers/:id(.:format)                    drivers#destroy
       metrics GET    /metrics(.:format)                        metrics#index
               POST   /metrics(.:format)                        metrics#create
        metric GET    /metrics/:id(.:format)                    metrics#show
               PATCH  /metrics/:id(.:format)                    metrics#update
               PUT    /metrics/:id(.:format)                    metrics#update
               DELETE /metrics/:id(.:format)                    metrics#destroy
```

## Testing

Exec command to run tests

```
rake test
```

## Try it

https://secure-ocean-19453.herokuapp.com

