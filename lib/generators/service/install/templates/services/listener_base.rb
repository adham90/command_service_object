# frozen_string_literal: true

require 'hutch'

class ListenerBase < SimpleDelegator
  include Hutch::Consumer
end