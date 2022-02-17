require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user){ create(:user) }
  let(:event){ create(:event, owner_id: user.id) }

  describe '#created_by?' do
    it 'イベントを作成したユーザーのとき、trueになること' do
      expect(event.created_by?(user)).to eq true
    end
  
    it 'イベントを作成したユーザーと違うとき、falseになること' do
      another_user = create(:user)
      expect(event.created_by?(another_user)).to eq false
    end
  
    it '引数がnilなとき、falseになること' do
      expect(event.created_by?(nil)).to eq false
    end
  end

  describe 'start_at_should_be_before_end_at バリデーション' do
    let(:time) { 1.days.from_now }
    let(:event) { build(:event, start_at: time, end_at: time + 1.seconds) }

    context 'start_atよりもend_atが後の日付のとき' do
      it { expect(event.valid?).to eq true }
    end
  
    context 'start_atよりもend_atが前の日付のとき' do
      let(:another_event) { build(:event, start_at: time, end_at: time - 1.seconds) }
      it { expect(another_event.valid?).to eq false }
    end
  end
end
