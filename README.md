# Qué pido?

Imagine this situation: you are at home. You are hungry. You have *no idea* of what you should order. Then this app is for you.

## Motivation

My girfriend and I *never* know what to order for food. So, it's an endless loop of "What should we have for diner? I don't know, what would you like? etc", going on... *forever*.  
So, this is a dead-simple solution to that question

## Usage
  - Run `bundle install`
  - Run `ruby quepido.rb`
  - Go to `http://localhost:4567/`
  - Order what you have just read there :)

## Docker

  - Run `docker build -t que-pido .`
  - Run `docker image rm que-pido:latest`
  - Go to `http://localhost:4567/`
  - Order what you have just read there :)

## Technical aspects

### Stack

  - Ruby 2.+
  - Some Sinatra version
  - ...

#### Why?

##### Why Ruby?

I love Ruby. Period.

##### Why Sinatra?

Sinatra is the simplest "web framework" existing. Well, Express might be as simple as Sinatra, but JavaScript isn't as fun as Ruby.

#### What about the DB?

Well, this took me five minutes. Writing this file took me twice that time;)
I'll add more stuff eventually, I really enjoy writing useless Ruby code :)
