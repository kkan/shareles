require 'mandrill'
class ShareController < ApplicationController
  def index
  end

  def send_member_invites
    from_name = "Shareleston Admin"
    from_email = "admin@shareleston.com"
    subject = "Demo subject"
    body = "Demo body"
    reg = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
    recipient_emails = params[:emails].scan(reg).uniq
    p recipient_emails
    recipient_emails.each do |email|
      m = Mandrill::API.new ENV['MANDRILL_SECRET_KEY']
      message = {
        from_name: from_name,
        from_email: from_email,
        to: [{"email" => email,"type" => "to"}],
        subject: subject,
        html: body,
        auto_text: true,
        preserve_recipients: false
      }
      begin
        result = m.messages.send message
      rescue Mandrill::Error => e
        puts "A mandrill error occurred: #{e.class} - #{e.message}"
        next
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def callback
    @contacts = request.env['omnicontacts.contacts']
    puts '1'*100, @contacts
    @project_id = session[:project_id]
    session[:contacts_imported] = true
    # @user_id = current_user.id
    # (0..@contacts.each_slice(1000).to_a.count-1).each_with_index do |i|
    #   Contact.import_contacts(@contacts.each_slice(1000).to_a[i],
    #                           @user_id)
    # end
    puts @contacts
    redirect_to "/share", notice: "Updating contacts.."
  end
end
