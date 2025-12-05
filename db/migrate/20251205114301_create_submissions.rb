class CreateSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :submissions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.integer :score, default: 0, null: false
      t.integer :total_points, null: false
      t.datetime :submitted_at

      t.timestamps
    end
  end
end
