class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :theater
  has_many :postings, dependent: :destroy

  validates :date, presence: true
  validates :time, presence: true

  def uf_date # user friendly date
    date.strftime("%-d %B")
  end

  def uf_date_long # user friendly date
    date.strftime("%-d %B %Y")
  end

  def uf_time # user friendly time
    time.strftime("%-H:%M")
  end
end
