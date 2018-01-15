# frozen_string_literal: true

module WebpackerSSR
  module React
    module Plugins
      class React < Plugin
        self.priority = 0

        JS_VARIABLES = <<~JS
          var React = this.React;
          var ReactDOMServer = this.ReactDOMServer;
        JS

        RENDER_TO_STRING = <<~JS
          var result = ReactDOMServer.renderToString(element);
        JS

        def set_up_js_variables(input) # rubocop:disable Naming/AccessorMethodName
          input + JS_VARIABLES
        end

        def set_up_components(_input, name)
          <<~JS
            var component = this[#{name.to_json}];
          JS
        end

        def set_up_elements(_input, props)
          <<~JS
            var element = React.createElement(component, #{props.to_json});
          JS
        end

        def render_to_string(input)
          input + RENDER_TO_STRING
        end
      end
    end
  end
end

WebpackerSSR::React.register_plugin(:react, WebpackerSSR::React::Plugins::React)
