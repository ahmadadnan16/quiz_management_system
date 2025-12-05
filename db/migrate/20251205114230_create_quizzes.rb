class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.string :title, null: false
      t.text :description
      t.string :slug, null: false
      t.boolean :published, default: false, null: false

      t.timestamps
    end
    
    add_index :quizzes, :slug, unique: true
  end
end
