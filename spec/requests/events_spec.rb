require "rails_helper"

RSpec.describe "EventsController", :type => :request do
  let(:user) { create(:user) }
  let(:event) { build(:event, owner_id: user.id )}
  let(:params) {
    {
      event: {
        name: event.name, 
        place: event.place,
        content: event.content, 
        start_at: event.start_at, 
        end_at: event.end_at
      }
    }
  }

  before do
    Rails.application.env_config['omniauth.auth'] = set_omniauth(user)
    get "/auth/:provider/callback"
  end

  describe "#create" do
    it "ログイン中のユーザーのEventが作られること" do
      expect{ post "/events/", params: params }.to change{ user.created_events.count }.from(0).to(1)
    end
  end

  describe "#update" do
    it "ログイン中のユーザーのEventがアップデートされること" do
      event.save
      expect{ patch "/events/#{event.id}", params: { event: { name: "hogehoge" } } }.to change{ event.reload.name }.from("イベント名2").to("hogehoge")
    end
  end

  describe "#delete" do
    it "ログイン中のユーザーのEventが削除されること" do      
      event.save
      expect{ delete "/events/#{event.id}" }.to change{ Event.all.size }.by(-1)
    end
  end

end
