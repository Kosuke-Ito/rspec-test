require "rails_helper"

RSpec.describe "EventsController", :type => :request do
  fdescribe "create" do
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

    context "ログインしているとき" do
      # パターン１
      before do
        Rails.application.env_config['omniauth.auth'] = set_omniauth(user)
        get "/auth/:provider/callback"
      end

      # パターン2
      # before do
      #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      # end

      it "ログイン中のユーザーのEventが作られること" do
        expect{ post "/events/", params: params }.to change{ user.created_events.count }.from(0).to(1)
      end

      it "ログイン中のユーザーのEventがアップデートされること" do
        event.save
        patch "/events/#{event.id}", params: { event: { name: "hogehoge" } }
        expect(event.reload.name).to eq "hogehoge"
      end

      it "ログイン中のユーザーのEventが削除されること" do      
        event.save
        expect(Event.all.count).to eq 1
        delete "/events/#{event.id}"
        expect(Event.all.count).to eq 0
      end
      
    end
  end
end
