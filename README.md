## Requirements
The list of requirements to install this app are:
* Ruby >= 3.0.x
* PostgreSQL

## Installation
* `` git clone https://github.com/resgar/digibank.git``
* `` bundle install ``
* `` yarn install ``

* Set Postgres usernam and password:
```
export POSTGRES_USERNAME='Your Postgres Username'
export POSTGRES_PASSWORD='Your Postgres Password'
```
* `` rails db:create && rails db:migrate ``

`` bundle exec rails server ``

* Visit http://localhost:3000 in your browser.

## Creating a new user
*  `rails console`
*  ` UserOperations::Registration::Create.new.(email: 'user@example.com',
 password: 'secret') `

## Running tests
` bundle exec rails test `
