module Rspec
  class ContextGenerator < ::Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def create_spec_file
      template(
        'context_spec.rb',
        File.join(
          'spec/contexts',
          class_path,
          "#{singular_name}_context_spec.rb"
        )
      )
    end
  end
end
