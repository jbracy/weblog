class ContactMailer < ActionMailer::Base

  def inquiry(form)
    @name = form[:nametext]
    @address = form[:emailtext]
    @message = form[:messagetext]
    @from = "#{@name} <#{@address}>"
    
    mail(:to => 'jebracy@gmail.com', :subject => "Blog Contact", :reply_to => @from, :return_path => @from)
  end

end