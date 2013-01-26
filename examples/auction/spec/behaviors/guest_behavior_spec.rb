require 'spec_helper'

describe Guest do
  extend_to { User.new }

  describe '#guest?' do
    subject { extended.guest? }

    it { should be_true }
  end
end
