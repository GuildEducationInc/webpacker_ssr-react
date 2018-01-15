# frozen_string_literal: true

require 'webpacker_ssr/react/pipeline'

module WebpackerSSR
  module React
    class ServerComponent
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::TextHelper

      attr_accessor :output_buffer

      def initialize(name, props, options)
        @name = name
        @props = props

        plugins = WebpackerSSR::React.config.default_plugins.dup
        plugins.concat(options.delete(:plugins)) if options.key?(:plugins)
        add_plugins(plugins)
        @options = options
      end

      def setup(controller)
        @controller = controller
      end

      def teardown(controller); end

      def call
        WebpackerSSR.render(pipeline.code)
      end

      def content
        @content ||= begin
          options = @options.dup
          tag = options.delete(:tag) || :div
          options.deep_merge!(remount_options) if remount?
          output = Array.wrap(call)
          safe_join([output[1..-1], content_tag(tag, nil, options) { output.first.html_safe }])
        end.html_safe
      end

      def remount?
        @options[:remount]
      end

      def remount_options
        @remount_options ||= WebpackerSSR::React.remounter.remount_options(@name, @props)
      end

      private

      def add_plugins(plugins)
        plugins.each { |p| pipeline.plugin(*p) }
      end

      def pipeline
        @pipeline ||= Pipeline.new(@name, @props)
      end
    end
  end
end
