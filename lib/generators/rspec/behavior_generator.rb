module Rspec
  class BehaviorGenerator < ::Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def create_spec_file
      template(
        'behavior_spec.rb',
        File.join(
          'spec/behaviors',
          class_path,
          "#{singular_name}_behavior_spec.rb"
        )
      )
    end
  end
end
