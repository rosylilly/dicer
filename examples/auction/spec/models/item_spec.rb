require 'spec_helper'

describe Item do
  subject(:item) { create(:item) }

  describe '#active?' do
    let(:now) { Time.now }
    around {|e| Timecop.freeze(now) { e.run } }

    subject { item.active? }

    context 'when period at is 2 days ago' do
      before do
        item.period_at = 2.days.ago
      end

      it { should be_false }
    end

    context 'when period at is 2 days since' do
      before do
        item.period_at = 2.days.since
      end

      it { should be_true }
    end

    context 'when period at is now' do
      before do
        item.period_at = Time.now
      end

      it { should be_true }
    end
  end
end
