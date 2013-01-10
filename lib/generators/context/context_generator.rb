require 'rails/generators'

module Rails
  module Generators
    class ContextGenerator < NamedBase
      source_root File.expand_path('../template', __FILE__)

      check_class_collision :suffix => 'Context'

      class_option :parent,
        :type => :string,
        :desc => 'The parent class for the generated context'

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

      private
      def parent_class_name
        options[:parent] || defined?(ApplicationContext) ?
          'ApplicationContext' : 'Dicer::Context'
      end
    end
  end
end
