class User < ActiveRecord::Base
  has_many :posts
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  before_create :encrypt_pw 

  def authenticate(pw_attempt)
    self.password == pw_attempt.crypt(self.salt)  
  end

  private
  
  def gen_salt
    salt = (('a'..'z').to_a + ('0'..'9').to_a*3).shuffle[0...2].join
    self.assign_attributes(salt: salt)
  end

  def encrypt_pw
    gen_salt
    encrypted_pw = self.password.crypt(self.salt)
    self.assign_attributes(password: encrypted_pw)
  end
end
