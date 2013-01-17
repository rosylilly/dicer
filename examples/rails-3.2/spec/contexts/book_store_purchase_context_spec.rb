require 'spec_helper'

describe BookStorePurchaseContext do
  controller do
    def hello; nil; end
  end

  it { should be_a BookStorePurchaseContext }

  its(:controller) { should respond_to :hello }
  its(:controller) { should == controller }
end
