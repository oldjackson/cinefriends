class Posting < ApplicationRecord
  belongs_to :user
  belongs_to :show
  has_many :pairings, dependent: :destroy

  validates :show, uniqueness: { scope: :user,
    message: "You already posted for this show." }
end
