# How To

Here you can try live tests [https://cbc-api.herokuapp.com/v1/](https://cbc-api.herokuapp.com/v1/)

**This application is using PostgreSql, in order to test it please make sure you have installed PostreSQL

* run `git clone git@github.com:slawa85/cbc.git`
* run `cd cbc && bundle install`
* run `rake db:create && rake db:migrate && rake db:seed` this will populate you db with test data
* run `rails s`

# How To Use

**This application is using `devise_jwt` to generate bearer tokens

To obtain a token you have to submit the following POST request:

* `http://your_local_domain/v1/users/sign_in?user[email]=demo1@test.com&user[password]=p@ssword1`

the bearer token you will receive in `Authorization` header, you will need it to access the private resources.

There are few conditions that application requires to pass the request:
* `headers['Accept'] = 'application/vnd.api.v1+json'`
* `headers['Content-Type'] = 'application/vnd.api.v1+json'`
* `headers['Authorization'] = 'Bearer jwt_token_from_above_description'`

**List of available endpoints

Values from parameter `country_code: ['DE', 'RO', 'FR']`

Private endpoints:
* GET `/v1/users/locations/:country_code`
* GET `/v1/users/target_groups/:country_code`
* POST `/v1/users/evaluate_target` => `/v1/users/evaluate_target?target_group[country_code]=DE&target_group[target_group_id]=12&target_group[locations][][id]=123&target_group[locations][][panel_size]=200&target_group[locations][][id]=1&target_group[locations][][panel_size]=200`

Public endpoints:
* GET `/v1/locations/:country_code`
* GET `/v1/target_groups/:country_code`
