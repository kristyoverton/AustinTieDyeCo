class ContactForm < MailForm::Base
  attribute :name      
  attribute :comment
  attribute :blanketid
  attribute :info


  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Someone Found a Blanket!",
      :to => "qsgiveaways@gmail.com",
      :from => %("#{name}")
    }
  end
end