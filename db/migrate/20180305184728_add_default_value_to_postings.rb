class AddDefaultValueToPostings < ActiveRecord::Migration[5.1]
  def change
    change_column_default :postings, :status, "pending"
  end
end
