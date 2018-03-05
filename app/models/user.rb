class User < ApplicationRecord

  has_many :messages, dependent: :destroy
  has_many :postings
  has_many :pairings
  has_many :genres, through: :genre_users
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
