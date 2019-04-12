# CommandServiceObject

Rails Generator for command service object.

### Theory:
[Command Design Pattern](https://en.wikipedia.org/wiki/Command_pattern) consists of `Command Object` and `Service Object` (Executor), Command object is responsible for containing `Client` requests and run input validations on it to ensure that the request is valid and set default values, then `Service Object` applies the business logic on that command.

### Implementation:
Service consists of several objects { `Command Object` ` Usecase Object`   And `Error Object` (business logic error) }.

- **Command Object:** the object that responsible for containing `Client` requests and run input validations it's implemented using [Virtus](https://github.com/solnic/virtus) gem and can use `activerecord` for validations and it's existed under `commands` dir.
- **Usecase Object:** this object responsible for executing the business logic, Every `usecase` should execute one command type only so that command name should be the same as usecase object name, usecase object existed under 'usecases` dir.
- **Error Object:** business logic errors existed user `errors` dir inside the service dir.

#### Result Object:
In case of  successful or failure `ApplicationService` the responsible object for all services will return `service_result` object this object contain `value!` method  containing successful call result, and `errors` method containing failure `errors` objects.

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

## Usage

    $ rails g service [service_name] [usecases usecases]
### Example

    $ rails g service user create update delete
output

```bash
create  app/services/user_service
create  app/services/user_service/usecases
create  app/services/user_service/commands
create  app/services/user_service/errors
create  app/services/user_service/usecases/create.rb
create  app/services/user_service/commands/create.rb
create  app/services/user_service/usecases/update.rb
create  app/services/user_service/commands/update.rb
create  app/services/user_service/usecases/delete.rb
create  app/services/user_service/commands/delete.rb
```
then you can edit command params
> you can read [Virtus gem docs](https://github.com/solnic/virtus) for more info. 
```ruby
# app/services/user_service/commands/create.rb
module UserService::Commands
  class Create
    include Virtus.model

    attribute :name, String
    attribute :phone, String
    attribute :age, Integer
  end
end
```
and then add your business logic
```ruby
# app/services/user_service/usecases/create.rb
module UserService::Usecases
  class Create < ServiceBase
    def call
        # your business logic goes here
        # keep call method clean by using private methods for Business logic
        do_something
        do_another_something
    end

    private

    def do_something
        # Business logic
        # Don't catch errors ApplicationService will do that for you
        raise Errors::CustomeError if ERROR
    end

    def do_another_something
        # another business logic
    end
  end
end
```

usage from controller
```ruby
class UsersController < ApplicationController
  def create
    cmd    = UserService::Commands::Create.new(user_params)
    result = ApplicationService.call(cmd)

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
