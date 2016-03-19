class ShareController < ApplicationController
  def index
  end

  def send_member_invites
    subject = "Demo subject"
    body = "Demo body"
    reg = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
    recipient_emails = params[:emails].scan(reg).uniq
    p recipient_emails
    recipient_emails.each do |email|
      #send email
    end
    # respond_to do |format|
    #   format.js { flash.now[:notice] = "Invites sent." }
    # end
    render nothing: true
  end

  def callback
    @contacts = request.env['omnicontacts.contacts']
    puts '1'*100, @contacts
    @project_id = session[:project_id]
    session[:contacts_imported] = true
    @user_id = current_user.id
    (0..@contacts.each_slice(1000).to_a.count-1).each_with_index do |i|
      Contact.import_contacts(@contacts.each_slice(1000).to_a[i],
                              @user_id)
    end
    redirect_to "/share", :notice => "Updating contacts.."
  end
end
