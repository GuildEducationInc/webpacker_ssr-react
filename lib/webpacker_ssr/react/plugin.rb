# frozen_string_literal: true

module WebpackerSSR
  module React
    class Plugin
      include Comparable

      class_attribute :priority

      def <=>(other)
        self.class.priority <=> other.class.priority
      end

      def identity(input, *_args)
        input
      end
      alias set_up_js_variables identity
      alias set_up_components identity
      alias set_up_elements identity
      alias render_to_string identity
    end
  end
end

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'plugins', '**', '*.rb'))].each { |f| require f }
