class Admin < ActiveRecord::Base
	attr_accessor :password, :password_confirmation

    email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

    #   Validate the form input
    validates :email,       presence:       true,
                            format:         { with:     email_regex },
                            uniqueness:     { case_sensitive: false }
    
    validates :password,    presence:       true,
                            confirmation:   true,
                            length:         { within:   4..100 }

    #   Before saving the user to DB, run this function.
    before_save :encrypt_password

    #   Encrypt the unencrypted password the user submitted, and compare to
    #   the saved encrypted version.  Return true if the passwords match.
    def has_password?(submitted_password)
        self.encrypted_password == encrypt(submitted_password)
    end

    #   Class method -- not overridable by object instances.  
    #   Check whether the user's email and submitted password are valid
    def self.authenticate(email, submitted_password)
        admin = find_by_email(email)

        return nil if admin.nil?
        return admin if admin.has_password?(submitted_password)
    end

  private

    def encrypt_password
        #   Generate a unique salt if user does not already exist.
        #   self.password uses attr_accessor defined above to allow the submitted password 
        self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{self.password}") if self.new_record?

        #   Encrypt the password and store it in encrypted_password
        self.encrypted_password = encrypt(self.password)        # self.password is what's in the post data!
    end

    #   Encrypt password using both salt and submitted password
    def encrypt(pass)
        Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
    end

end
