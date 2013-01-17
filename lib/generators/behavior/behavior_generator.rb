require 'rails/generators'

module Rails
  module Generators
    class BehaviorGenerator < NamedBase
      source_root File.expand_path('../template', __FILE__)

      def create_behavior_file
        template(
          'behavior.rb',
          File.join(
            'app/behaviors',
            class_path,
            "#{file_name}.rb"
          )
        )
      end

      hook_for :test_framework
    end
  end
end
