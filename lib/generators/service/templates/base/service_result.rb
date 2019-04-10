# frozen_string_literal: true

class ServiceResult
  attr_reader :error

  def initialize
    @value = yield
    @error = nil
  rescue StandardError => e
    @error = e
  end

  def to_s
    if ok?
      format('#<Result:0x%x value: %s>', object_id, @value.inspect)
    else
      format('#<Result:0x%x error: %s>', object_id, @error.inspect)
    end
  end

  alias inspect to_s

  def then
    return self unless ok?

    result = yield(@value)
    raise TypeError, 'block invoked in Result#then did not return Result' unless result.is_a?(Result)

    result
  end

  def rescue
    return self if ok?

    result = yield(@error)
    raise TypeError, 'block invoked in Result#rescue did not return Result' unless result.is_a?(Result)

    result
  end

  def value
    raise ArgumentError, 'must provide a block to Result#value to be invoked in case of error' unless block_given?

    return @value if ok?

    yield(@error)
  end

  def value!
    raise @error unless ok?

    @value
  end

  def ok?
    !@error
  end

  def self.error(err)
    result = allocate
    result.instance_variable_set(:@error, err)
    result
  end
end
