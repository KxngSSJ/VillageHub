class CreateRatings < ActiveRecord::Migration[8.0]
  def change
    create_table :ratings do |t|
      t.integer :score
      t.references :user, null: false, foreign_key: true
      t.references :work_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
