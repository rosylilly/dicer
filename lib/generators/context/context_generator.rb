require 'rails/generators'

module Rails
  module Generators
    class ContextGenerator < NamedBase
      source_root File.expand_path('../template', __FILE__)

      check_class_collision :suffix => 'Context'

      def create_context_file
        template(
          'context.rb',
          File.join(
            'app/contexts',
            class_path,
            "#{file_name}_context.rb"
          )
        )
      end
    end
  end
end
