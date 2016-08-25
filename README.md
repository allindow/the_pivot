# Lending Hands 

### Introduction

[Lending Hands](http://lendinghands.herokuapp.com/) is a Turing School of Software & Design project called The Pivot for Module 3. The goal of the project was to transform a simple e-commerce store into a multitenancy store. [Lending Hands](http://lendinghands.herokuapp.com/), a microlending platform, was pivoted from [Alicorn Adoption](http://alicorn-adoption.herokuapp.com/) which is a mythical creature adoption site. 

[Alicorn Adoption Repo](https://github.com/roscalabrin/alicorn_adoption)

### Features

Lending Hands includes MVC architecture using Rails, database transactions and logic operations using ActiveRecord, user authorization, user authentication, a functional shopping cart for single browsing sessions, Stripe integration, multitenancy, and different levels of authorization (registered user, organization admin, platform admin), and Javascript methods.

The site uses different controllers for users based on their role, allowing for different levels of authorization and use. 

All users are able to create accounts with a unique username and email address. Organization admins may assign other users to be co-admins with their organization. Platform admins can view all fundings. All visitors and users can fill a shopping cart with microloans, but only registered and logged-in users are allowed to check out. 

### Extensions

Several features were implemented which were not part of the core curriculum. These include accepting payment from a third-party source. Paypal inclusion was attempted initially, but Stripe lasted as the chosen method for third-party payment validation. The use of jQuery to allow real-time updating of features without page refreshing was added where it seemed sensible, such as the fuzzy finder search bar on the All Recipients page. 

### Usage

To run this application on your local host,

```$ git clone git@github.com:allindow/the_pivot.git```

then bundle

```$ bundle install```

set up your database

```$ rake db:drop db:create db:migrate db:seed```

run your server

```$ rails s```

navigate to your local host, and enjoy!


Contributors:
* [Tommasina Miller](https://github.com/chompasina)
* [Angela Lindow](https://github.com/allindow)
* [Lin McCartney](https://github.com/lcmccartney)
* [Caleb Cowen](https://github.com/Caleb9193)
