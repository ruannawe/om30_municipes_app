# README

## Overview
This Rails application manages citizen data, including personal details, addresses, and photos. Features include phone number and CNS number validations, address autofill using an external API, and image storage with AWS S3. For more details, please check the [link](https://github.com/OM30/desafio-OM30/blob/master/DesafioBackendRuby.md).

## Ruby Version
- Ruby 3.2.2
- Rails 7.1.2

## System Dependencies
- PostgreSQL for the database.

## Configuration
- Set up AWS S3 for image storage.
- Configure an external API for address autofill.

## Database Creation and Initialization
- Run `rails db:create` and `rails db:migrate`.
- Seed data using `rails db:seed`.

## Running the Test Suite
- Run tests with `rspec`.

## Services
- AWS S3 for image storage.
- Zipcodebase API for address autofill.

## Deployment Instructions
- Just push the code to the `main` branch and the magic happens.

## Additional Notes
- Custom validations for phone numbers and CNS numbers.
- CORS configuration details for AWS S3.
- Error handling for image uploads and external API responses.
