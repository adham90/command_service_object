# CommandServiceObject

Rails Generator for command service object.

### Theory:
[Command Design Pattern](https://en.wikipedia.org/wiki/Command_pattern) consists of `Command Object` and `Service Object` (Executor), Command object is responsible for containing `Client` requests and run input validations on it to ensure that the request is valid and set default values, then `Service Object` applies the business logic on that command.

### Implementation:
Service consists of several objects { `Command Object` ` Usecase Object`   And `Error Object` (business logic error) }.

- **Command Object:** the object that responsible for containing `Client` requests and run input validations it's implemented using [Virtus](https://github.com/solnic/virtus) gem and can use `activerecord` for validations and it's existed under `commands` dir.
- **Usecase Object:** this object responsible for executing the business logic, Every `usecase` should execute one command type only so that command name should be the same as usecase object name, usecase object existed under 'usecases` dir.
- **Micros:** small reusable logic under the same service.

#### Result Object:
In case of successful or failure `ApplicationService` the responsible object for all services will return `service_result` object this object contain `value!` method containing successful call result, and `errors` method containing failure `errors` objects.

#### Business Logic Failures
To raise bussiness logic failures you can use `fail!` helper method with `message: String, extra_data: Hash` arguments.

> You can check if the result successful or not by using `ok?` method.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'command_service_object'
```
And then execute:

    $ bundle

Or install it yourself as:

    $ gem install command_service_object

Next, you need to run the generator:

```bash
$ rails generate service:install
```

## Usage

    $ rails g service [service_name] [usecases usecases]
### Generate Service ex:

    $ rails g service auth login
output

```bash
app/services/
├── application_service.rb
├── external/
├── auth_service
│   ├── commands
│   │   └── login.rb
│   └── usecases
│       ├── login.rb
│       └── micros
├── case_base.rb
└── service_result.rb
```

### Generate micros ex:

    $ rails g service:micro auth generate_jwt_token_for

```bash
app/services/
├── auth_service
│   └── usecases
│       └── micros
│           └── generate_jwt_token_for.rb
```

```ruby
# app/services/auth_service/usecases/micros/generate_jwt_token_for.rb

module PaymentService::Usecases::Micros
  class GenerateJwtTokenFor < CaseBase
    def call
        # <Payload>
    end
  end
end
```

then you can edit command params
> you can read [Virtus gem docs](https://github.com/solnic/virtus) for more info. 
```ruby
# app/services/auth_service/commands/login.rb
# frozen_string_literal: true

module AuthService::Commands
  class Login
    # You can read Virtus gem doc for more info.
    # https://github.com/solnic/virtus
    include Virtus.model
    include ActiveModel::Validations

    # Attributes
    # attribute :REPLACE_ME, String

    # Validations
    # validates :REPLACE_ME, presence: true
  end
end
```
and then add your business logic
```ruby
# app/services/auth_service/usecases/login.rb
# frozen_string_literal: true

module AuthService::Usecases
  class Login < CaseBase
    include CommandServiceObject::Hooks
    micros :generate_jwt_token_for
    #
    # Your business logic goes here, keep [call] method clean by using private
    # methods for Business logic.
    #
    def call
      token = generate_jwt_token_for(user)
    end

    # This method will run if call method raise error
    def rollback
      # rollback logic
    end

    private

      def replace_me
        # [business logic]
      end
  end
end
```

### External APIs or Services
You can wrap external apis or services under `external/` dir
#### ex:
```ruby
module External
  class StripeService
    class << self
      def charge(customer:, amount:, currency:, description: nil)
        Stripe::Charge.create(
          customer:    customer.id,
          amount:      (round_up(amount, currency) * 100).to_i,
          description: description || customer.email,
          currency:    currency
        )
      end
    end
  end
end
```

usage from controller
```ruby
class AuthenticationController < ApplicationController
  default_service :auth_service

  def Login
    cmd    = command.new(params) # AuthService::Commands::Login.new
    result = execute(cmd)

    if result.ok?
      render json: result.value!.as_json, status: 201
    else
      render json: { message: result.error }, status: 422
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adham90/command_service_object. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CommandServiceObject project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/adham90/command_service_object/blob/master/CODE_OF_CONDUCT.md).
