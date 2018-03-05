class Posting < ApplicationRecord
  belongs_to :user_id
  belongs_to :movie_id
  belongs_to :theater_id
  validates :first_time, presence: true
  validates :last_time, presence: true
  validates :first_date, presence: true
  validates :last_date, presence: true
  validates :status, inclusion: {in: %w(pending accepted declined)}
end
