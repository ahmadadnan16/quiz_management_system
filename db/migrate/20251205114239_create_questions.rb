class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.text :prompt, null: false
      t.string :question_type, null: false
      t.integer :position, default: 0
      t.integer :points, default: 1, null: false
      t.string :correct_answer
      t.text :explanation

      t.timestamps
    end
    
    add_index :questions, [:quiz_id, :position]
  end
end
