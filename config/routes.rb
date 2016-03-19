Rails.application.routes.draw do
  get '/share', to: 'share#index', as: :share
  get "/contacts/:importer/callback", to: "share#callback", as: :share_callback
  # get '/callback', to: 'share#callback', as: :callback
  post '/send_member_invites', to: 'share#send_member_invites', as: :send_member_invites
end
