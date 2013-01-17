require 'spec_helper'

describe Testable do
  extend_to { User.new }

  it { should respond_to(:testable?) }
end
