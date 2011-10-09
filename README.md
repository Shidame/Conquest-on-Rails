# Conquest on Rails

Conquest on Rails is a browser-based wargame. It's open source and heavily inspired by RISK.


## Why?

My goal by building "Conquest on Rails" is to provide examples of how one can build a game with Ruby on Rails.

I think that showing how to create todo lists or blogs is a really boring way to learn. Building a game is far more exciting!


## With what?

The game is built on many technologies:

- Ruby on Rails
- HTML, CSS and jQuery
- MySQL, or Postgres if you prefer
- Juggernaut, to push data to browsers
- Resque, to embrace asynchronous way
- Redis, to power Resque and Juggernaut


## The game itself

The user come on the site and create an account with few informations (a display name, an email and a password).

Once on the dashboard, the player can start looking for a game. The system will search for players and notifiy them when the game is ready to start.
