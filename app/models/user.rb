class User < ApplicationRecord
	include BCrypt

  has_many :subscriptions
  has_many :channels, through: :subscriptions

  validates :email, { presence: true, uniqueness: true }
  validates :hashed_password, { presence: true }

  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end
end
