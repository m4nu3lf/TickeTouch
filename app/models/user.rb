require 'digest/sha1'

class User < ActiveRecord::Base
  email_regex = /\A[\w+\-]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true
  validates :surname, :presence => true
  validates :username, :presence => true, :uniqueness => {:case_sensitive => :false}
  validates :email, :presence => true, :uniqueness => {:case_sensitive => :false},
            :format => { :with => email_regex }
  attr_accessor :password_confirmation
  validates :password, :confirmation => true
  validate :password_non_blank

  attr_protected :username, :as => :update

  #TODO verify email format


  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def self.authenticate(username, password)
    user  = self.find_by_username(username)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  has_many :purchases

  private

  def password_non_blank
    errors.add(:password) if hashed_password.blank?
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
