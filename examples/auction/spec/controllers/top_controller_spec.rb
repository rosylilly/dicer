require 'spec_helper'

describe TopController do

  describe "GET 'top'" do
    it "returns http success" do
      get 'top'
      response.should be_success
    end
  end

end
