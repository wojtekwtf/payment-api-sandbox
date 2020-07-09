# Payment Sandbox
A fun & short Elixir implementation of a CRUD payments API. Features include:
- Historical transactions should be generated going back a few months for an account, with new transactions appearing over time
- Repeat requests should return the same account information however the balances should behave like a real bank account and occasionally change
- The sum of the transactions should match the balance of the account resource they are associated with
- No databases or data stores — the data is generated in real time on server
- Token authentication (however it doesn't identify the user – just check for token properties)
## API structure

### Authorization header
Sandbox requests require a header `Authorization`. Its value should be a 28 characters long string starting with `test_`.
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
- Run tests with coverage report (91.1%) `mix test --cover`
### Dialyzer
- Run dialyzer (static analysis tool) with `mix dialyzer` 

## Further development
The project is not production ready. If I had more time to work on it, I would add:
1. Pagination
2. OpenAPI docs
3. Real authentication
4. Database with some dummy data
5. 100% test coverage 😳
6. Real /transactions/:id endpoint


## Disclaimer
This has originally been a recruitment task for a fintech *company*. I didn't get the
job, so the repo is now open sourced. You can probably tell by the old commits.
I only anonymized it so search engines don't index it as *company* recruitment task

I am low key satisfied with it and don't want the time devoted to the project to be lost.
I think that's fair, but if you are from the *company* and think otherwise please let me know.
