require 'spec_helper'

require 'generators/behavior/behavior_generator'

describe Rails::Generators::BehaviorGenerator do
  destination ::File.expand_path('../../../tmp', __FILE__)
  arguments %w(Your)

  before do
    prepare_destination
    run_generator
  end

  specify 'should generate app/behaviors/your.rb' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'behaviors' do
          file 'your.rb' do
            contains 'module Your'
            contains 'include Dicer::Behavior'
          end
        end
      end
    end
  end
end
