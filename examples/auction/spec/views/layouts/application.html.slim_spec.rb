require 'spec_helper'

describe 'layouts/application.html.slim' do
  subject { render; rendered }

  context 'when not logined' do
    before do
      controller.singleton_class.class_eval do
        def logined?; false; end
        helper_method :logined?
      end
    end

    it { should have_link('Sign In', href: sign_in_path) }
    it { should have_link('Sign Up', href: sign_up_path) }
  end

  context 'when logined' do
    before do
      controller.singleton_class.class_eval do
        def logined?; true; end
        helper_method :logined?
      end
    end

    it { should have_link('Sign Out', href: sign_out_path) }
  end
end

