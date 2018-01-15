# frozen_string_literal: true

module WebpackerSSR
  module React
    module Remounters
      module WebpackerReact
        def self.remount_options(name, props)
          { data: { 'react-class' => name, 'react-props' => props.to_json } }
        end

        WebpackerSSR::React.register_remounter(:webpacker_react, self)
      end
    end
  end
end
