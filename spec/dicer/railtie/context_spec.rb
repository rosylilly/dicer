require 'spec_helper'

describe Dicer::Context do
  let(:context) { Dicer::Context.new }
  let(:controller) { ActionController::Base.new }

  describe '.current' do
    subject { described_class.current }

    it { should be_nil }

    context 'when set current context' do
      before(:all) do
        described_class.current = context
      end

      it { should == context }

      context 'in another thread' do
        around {|e| Thread.new(e) {|e| e.run }.join }

        it { should_not == context }
      end
    end
  end

  describe '.current_controller' do
    subject { described_class.current_controller }

    it { should be_nil }

    context 'when set current controller' do
      before(:all) do
        described_class.current_controller = controller
      end

      it { should == controller }

      context 'when another thread' do
        around {|e| Thread.new(e) {|e| e.run }.join }

        it { should_not == controller }
      end
    end
  end

  describe '#controller' do
    before { described_class.current_controller = controller }

    subject { context.controller }

    it { should == controller }
  end

  describe '#request' do
    let(:request) { mock }

    before do
      controller.request = request
      described_class.current_controller = controller
    end

    subject { context.request }

    it { should == request }
  end

  describe '#params' do
    let(:params) { mock }

    before do
      controller.params = params
      described_class.current_controller = controller
    end

    subject { context.params }

    it { should == params }
  end

  describe '#cookies' do
    let(:cookies) { mock }

    before do
      controller.request = mock(:cookie_jar => cookies)
      described_class.current_controller = controller
    end

    subject { context.cookies }

    it { should == cookies }
  end

  describe '#session' do
    let(:session) { mock }

    before do
      controller.request = mock(:session => session)
      described_class.current_controller = controller
    end

    subject { context.session }

    it { should == session }
  end
end
