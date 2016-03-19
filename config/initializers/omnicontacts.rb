require "omnicontacts"
Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "811866671956-nvkohgmh9c2qno7fgt2n4nctprsp2edt.apps.googleusercontent.com", "wIwZUuOp9t7rh_BeBUAyLvpI", { redirect_path: "/contacts/gmail/callback" }
end