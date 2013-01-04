require 'spec_helper'

require 'generators/context/context_generator'

describe Rails::Generators::ContextGenerator do
  destination ::File.expand_path('../../../tmp', __FILE__)
  arguments %w(Your)

  before do
    prepare_destination
    run_generator
  end

  specify 'should generate app/contexts/your_context.rb' do
    destination_root.should have_structure do
      directory 'app' do
        directory 'contexts' do
          file 'your_context.rb' do
            contains 'class YourContext < Dicer::Context'
          end
        end
      end
    end
  end
end
