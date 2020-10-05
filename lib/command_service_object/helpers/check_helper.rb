module CommandServiceObject
  module CheckHelper
    def check!(message, &block)
      raise "No block given" unless block_given?

      fail!(message) unless block.call
    end
  end
end
