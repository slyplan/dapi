# Gett challenge app

## About the application

To build API used http://jsonapi.org/ specification
Data models stored at `app/models`

## Setting up

Clone repository

```
git clone https://github.com/slyplan/dapi.git
```

Change `config/database.yml` and run the command, it will create the database and load driver and metrics which stored at https://github.com/gtforge/CodeChallenge
```
rake db:setup
```

![Metrics without specifyed driver will be discarded]

## CRUD

### Get driver

```
GET /drivers/1
```

## Testing

Exec command to run tests

```
rake test
```

## Try it

https://secure-ocean-19453.herokuapp.com

