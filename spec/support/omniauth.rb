module OmniAuthHelpers
  def set_omniauth(user)
    OmniAuth.config.test_mode = true
    
    OmniAuth.config.add_mock(
      user.provider,
      uid: user.uid,
      info: { 
        nickname: user.name,
        image: user.image_url 
      }
    )
  end
end