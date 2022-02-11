class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :user
      t.integer :stars
      t.string :review
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
