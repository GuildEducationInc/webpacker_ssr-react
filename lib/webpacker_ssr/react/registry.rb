# frozen_string_literal: true

module WebpackerSSR
  module React
    class Registry
      def initialize
        @registry = {}
      end

      def register(name, klass)
        @registry[name] = klass
      end

      def [](name)
        @registry[name]
      end

      def available?(name)
        @registry.key?(name)
      end
    end
  end
end
