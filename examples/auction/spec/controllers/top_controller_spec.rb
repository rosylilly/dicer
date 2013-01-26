require 'spec_helper'

describe TopController do
  describe "GET 'top'" do
    subject { get :top }

    it { should be_success }
    it { should render_template(:top) }
  end
end
