class User < ActiveRecord::Base
  has_secure_password
  
  validates :name, length: 2..20,
                   format: /^[a-z-]+$/i,
                   uniqueness: true,
                   presence: true
                   
  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                    presence: true,
                    uniqueness: true
                    
  validates :password, presence: true, on: 'create'
  validates :password_confirmation, presence: true, on: 'create'
  
  has_many :participations
end
