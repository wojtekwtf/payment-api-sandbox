# Teller Sandbox

Hello Stevie & Dan! 👋

This is the repo for the recruitment task that Tim gave me. Hope you will enjoy it!

I recorded a short video walk-through, for easier testing / getting familiar with
the project. Hope you enjoy it! *PLACEHOLDER*

The API has been deployed with [Gigalixir](https://teller-sandbox.gigalixirapp.com/accounts/) (without the LiveDashboard)

## API structure

### Authorization header
Sandbox requests require a header `Authorization`. Its value should be a string starting with word `test_`.
You can obtain it with the `GET /token` endpoint.

### Endpoints

- `GET /token`
  
  Returns the token needed for the authentication of other requests
- `GET /accounts`
  
  Returns a list of *account* objects.

  🔑 requires *authorization* header.
- `GET /accounts/:account_id`
  
  Returns a single *account* object.

  🔑 requires *authorization* header.
- `GET /accounts/:accounts_id/transactions`
  
  Returns a list of all *transaction* objects that are connected to the chosen
  *account* object.
  
  🔑 requires *authorization* header.
- `GET /accounts/:accounts_id/transactions/:transaction_id`
  
  Although it should return a single *transaction* object, it returns a list.
  It works like that because the transactions are currently generated on the fly
  and it's impossible to distinguish them by ids — they change all the time.
  
  🔑 requires *authorization* header.

- `GET /dashboard/`

  Opens the telemetry dashboard

## Project setup
### Local environment
- Install dependencies with `mix deps.get`
- Start Phoenix server with `mix phx.server`
### Tests
- Run tests `mix test`
### Dialyzer
- Run dialyzer (static analysis tool) with `mix dialyzer` 

## Further development
The project is not production ready. If I had more time to work on it, I would add:
1. Pagination
2. OpenAPI docs
3. Real authentication
4. Database with some dummy data


## Summary
Thanks for giving my application a chance! My finance and tech inside nerds will be so
excited about working on Teller. Let's not disappoint them!
