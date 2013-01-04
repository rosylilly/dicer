require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.create(:user) }

  context 'when set context' do
    let(:context) do
      Class.new(Dicer::Context) do
        describe User do
          it_behaves_like(Module.new {
            include Dicer::Behavior
            def hello; 1; end
          })
        end
      end.new
    end

    before do
      FactoryGirl.create(:user)
      Dicer::Context.current = context
    end

    describe '.all' do
      subject { User.all[0] }

      it { should respond_to(:hello) }
    end

    describe '.first' do
      subject { User.first }

      it { should respond_to(:hello) }
    end

    describe '.last' do
      subject { User.last }

      it { should respond_to(:hello) }
    end

    describe '.new' do
      subject { User.new }

      it { should respond_to(:hello) }
    end

    describe '.create' do
      subject { User.create(FactoryGirl.attributes_for(:user)) }

      it { should respond_to(:hello) }
    end
  end

  describe '#in_context' do
    it { should respond_to(:in_context) }
  end

  describe '#books' do
    subject { user.books }

    it { should be_empty }
  end
end
