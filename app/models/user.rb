class User < ApplicationRecord

  before_save :default_values

  paginates_per 10
  max_paginates_per 10

  
  has_many :reviews
  
  has_secure_password

  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, length: { in: 6..20 }, on: :create

  def full_name
    "#{firstname} #{lastname}"
  end

  def default_values
    self.admin ||= false
  end

end
