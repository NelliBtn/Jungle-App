class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, :uniqueness => { :case_sensitive => false }
  validates :password, presence: true, length: { minimum: 8 }

  # before_validation :strip_whitespace, :only => [:email]

  # def self.strip_whitespace
  #   self.email = self.email.strip
  # end


  # Define a new class method authenticate_with_credentials on the User model
  def self.authenticate_with_credentials(email_input, password_input)
    if email_input
     updated_email_input = email_input.strip
    end
    user = User.find_by_email(updated_email_input)
    if user && user.authenticate(password_input)
      user
    else
      nil
    end
  end


end
