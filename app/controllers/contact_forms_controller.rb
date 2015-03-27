class ContactFormsController < ApplicationController 

def new 
	@contact_form = ContactForm.new 
end 

def create 
	@contact_form = ContactForm.new(params[:contact_form]) 
	#@contact_form.request = request 
	if @contact_form.deliver 
		flash[:notice] = 'Thank you for your message!'
		redirect_to users_dash_path
	else 
		redirect_to users_dash_path 
	end 
end 

end