# frozen_string_literal: true

require 'webpacker_ssr/react/registry'

module WebpackerSSR
  module React
    class Configuration
      DEFAULT_PLUGINS = %i[react].freeze

      attr_accessor :remount_strategy
      attr_reader :plugins, :remounters
      attr_writer :default_plugins

      def initialize
        @plugins = Registry.new
        @remounters = Registry.new
        @default_plugins = []
        @remount_strategy = :webpacker_react
      end

      def default_plugins
        @default_plugins.empty? ? DEFAULT_PLUGINS : @default_plugins
      end

      def remounter
        remounters[remount_strategy]
      end
    end
  end
end
