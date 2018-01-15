# frozen_string_literal: true

require 'webpacker_ssr/react/plugin'

module WebpackerSSR
  module React
    class Pipeline
      attr_accessor :plugins

      def initialize(component_name, props = {})
        @component_name = component_name
        @props = props
        @plugins = {}
      end

      def plugin(name, *args)
        klass = WebpackerSSR::React.plugins[name]
        return false if klass.nil?
        @plugins[name] = klass.new(*args)
        true
      end

      # The build is divided into 4 steps:
      #
      # 1. Set up JS variables
      # 2. Set up component
      # 3. Set up element
      # 4. Render to string
      #
      # Each plugin potentially can modify or augment each step
      def code
        @code ||= <<~JS
          #{set_up_js_variables}
          #{set_up_components}
          #{set_up_elements}
          #{render_to_string}
          return result;
        JS
      end

      private

      def pipeline
        @pipeline ||= @plugins.values.sort
      end

      def set_up_js_variables
        pipeline.reduce('') { |memo, plugin| plugin.set_up_js_variables(memo) }
      end

      def set_up_components
        pipeline.reduce('') { |memo, plugin| plugin.set_up_components(memo, @component_name) }
      end

      def set_up_elements
        pipeline.reduce('') { |memo, plugin| plugin.set_up_elements(memo, @props) }
      end

      def render_to_string
        pipeline.reduce('') { |memo, plugin| plugin.render_to_string(memo) }
      end
    end
  end
end
