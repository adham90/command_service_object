module CommandServiceObject
  module CheckHelper
    def check!(message, &block)
      raise "No block given" unless block_given?

      fail!(message) if block.call
    end
  end
end
