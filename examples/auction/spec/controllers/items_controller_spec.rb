require 'spec_helper'

describe ItemsController do
  describe 'GET show' do
    subject { get :show, id: id }

    context 'when found item' do
      let(:id) { item.id }
      let(:item) { create(:item) }

      it { should be_success }
      it { should render_template(:show) }
    end

    context 'when not found item' do
      let(:id) { Item.all.count + 1 }

      it { should be_not_found }
    end
  end
end
