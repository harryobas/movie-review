# Introduction

A tiny Ruby on Rails application that manages movies and their reviews providing the following features:

1. Import movies and reviews data from csv files

2. Show overview of movies

3. search for a movie actor

4. Sort movies overview

# Requirements

1. Ruby 2.6.6

2. Rails 5.2.6

3. postgresql

# How to run

## Docker

This app is dockerized to enable both ease of installation and execution on either Linux, mac or windows. To install/run on Linux, make sure to have both docker and docker-compose installed on your machine and follow the instructions below:

1. $ git clone https://github.com/harryobas/movie-review.git
2. $ cd movie-review
3. $ sudo docker-compose build
4. $ sudo docker-compose up -d
5. $ sudo docker-compose exec web rails db-migrate
6. $ sudo docker-compose exec web rake import:import_csv


