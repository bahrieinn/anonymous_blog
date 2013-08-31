class User < ActiveRecord::Base
  has_many :posts
  validates :email, presence: true, uniqueness: true
  before_create :encrypt_pw 

  private
  
  def gen_salt
    salt = (('a'..'z').to_a + ('0'..'9').to_a*3).shuffle[0...2].join
    self.assign_attributes(salt: salt)
  end

  def encrypt_pw
    gen_salt
    encrypted_pw = self.pw_hash.crypt(self.salt)
    self.assign_attributes(pw_hash: encrypted_pw)
  end
end
