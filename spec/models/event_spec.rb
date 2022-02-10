require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.create(:event)
    @user = @event.owner
  end

  it '#created_by? owner_id と 引数の#id が同じとき' do
    expect(@event.created_by?(@user)).to eq true
  end

  it '#created_by? owner_id と 引数の#id が異なるとき' do
    another_user = FactoryBot.create(:user)
    expect(@event.created_by?(another_user)).to eq false
  end

  it '#created_by? 引数が nil なとき' do
    expect(@event.created_by?(nil)).to eq false
  end

  it 'start_at_should_be_before_end_at validation OK' do
    expect(@event.valid?).to eq true
  end

  it '開始は終わりよりも前じゃないといけない validation error' do
    @event.end_at = @event.start_at - rand(1..30).hours
    expect(@event.valid?).to eq false
  end
end
