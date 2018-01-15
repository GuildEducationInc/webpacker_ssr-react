# frozen_string_literal: true

require 'webpacker_ssr/react/view_helpers'

module WebpackerSSR
  module React
    class Railtie < Rails::Railtie
      initializer 'webpacker_ssr.react.view_helpers' do
        ActionView::Base.send(:include, WebpackerSSR::React::ViewHelpers)
      end
    end
  end
end
