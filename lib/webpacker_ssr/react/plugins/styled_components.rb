# frozen_string_literal: true

module WebpackerSSR
  module React
    module Plugins
      class StyledComponents < Plugin
        self.priority = 50

        JS_VARIABLES = <<~JS
          var ServerStyleSheet = this.ServerStyleSheet;
        JS

        COMPONENTS = <<~JS
          var sheet = new ServerStyleSheet();
        JS

        RENDER_TO_STRING = <<~JS
          var html = ReactDOMServer.renderToString(sheet.collectStyles(element));
          var styles = sheet.getStyleTags();
          var result = [html, styles];
        JS

        def set_up_js_variables(input) # rubocop:disable Naming/AccessorMethodName
          input + JS_VARIABLES
        end

        def set_up_components(input, _name)
          input + COMPONENTS
        end

        def render_to_string(_input)
          RENDER_TO_STRING
        end
      end
    end
  end
end

WebpackerSSR::React.register_plugin(:styled_components, WebpackerSSR::React::Plugins::StyledComponents)
