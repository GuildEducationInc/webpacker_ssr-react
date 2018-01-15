# frozen_string_literal: true

require 'webpacker_ssr'
require 'webpacker_ssr/react/configuration'
require 'webpacker_ssr/react/railtie' if defined?(Rails)
require 'webpacker_ssr/react/version'

module WebpackerSSR
  module React
    class << self
      def config
        @config ||= Configuration.new
      end

      def plugins
        config.plugins
      end

      def remounter
        config.remounter
      end

      def register_plugin(name, klass)
        plugins.register(name, klass)
      end

      def register_remounter(name, klass)
        config.remounters.register(name, klass)
      end
    end
  end
end

WebpackerSSR.register_configuration(:react, WebpackerSSR::React.config)

require 'webpacker_ssr/react/server_component'
Dir[File.expand_path(File.join(File.dirname(__FILE__), 'react', 'remounters', '**', '*.rb'))].each { |f| require f }
