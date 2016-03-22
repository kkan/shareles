require "omnicontacts"
Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, ENV['GOOGLE_APP_CLIENT_ID'], ENV['GOOGLE_APP_CLIENT_SECRET'], { redirect_path: "/contacts/gmail/callback" }
end