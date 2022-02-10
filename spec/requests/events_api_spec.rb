require 'rails_helper'


RSpec.describe "Events API", type: :request do
  it '#show' do
    @event = FactoryBot.create(:event)
    user = @event.owner
    get root_path
    expect(response).to have_http_status(:success)
    expect(response.body).to include('イベント名1')
  end

  it '#create' do
    OmniAuth.config.mock_auth[:github] = nil
    Rails.application.env_config['omniauth.auth'] = sign_in_as(FactoryBot.create(:user))
    binding.pry
    # post event_path, params: { 
    #                     name: "a",
    #                     place: "a", 
    #                     image: "a", 
    #                     remove_image: "a",
    #                     content: "a",
    #                     start_at: "2022-12-30",
    #                     end_at: "2022-12-31"
    #                   }
    # current_user.created_events.build(event_params)
  end

  # it '#edit' do
    
  # end

  # it '#delete' do
    
  # end

end
