# frozen_string_literal: true

module WebpackerSSR
  module React
    module ViewHelpers
      def react_server_component(name, props, options = {})
        ServerComponent.new(name, props, options).content
      end
    end
  end
end
