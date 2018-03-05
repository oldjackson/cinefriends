class CreatePostings < ActiveRecord::Migration[5.1]
  def change
    create_table :postings do |t|
      t.references :user_id, foreign_key: true
      t.string :status
      t.references :movie_id, foreign_key: true
      t.references :theater_id, foreign_key: true
      t.time :first_time
      t.time :last_time
      t.date :first_date
      t.date :last_date

      t.timestamps
    end
  end
end
