require 'spec_helper'

describe Authenticatable do
  extend_to { User.new }

  describe '#guest?' do
    subject { extended.guest? }

    it { should be_false }
  end
end
