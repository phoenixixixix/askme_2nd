require 'openssl'

class User < ApplicationRecord
  # параметри роботи модуля шифрування паролів
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  EMAIL_FORMAT = /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  USERNAME_FORMAT = /\A\w+\z/

  has_many :questions

  attr_accessor :password


  validates :email, :username, presence: true, uniqueness: true
  validates :email, format: { with: EMAIL_FORMAT }
  validates :username, length: { maximum: 40 }, format: { with: USERNAME_FORMAT }

  validates :password, presence: true, on: :create
  validates :password, confirmation: true


  before_save :encrypt_password


  def self.authenticate(email, password)
    user = find_by(email: email)

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end
end
