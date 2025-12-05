class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.references :submission, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :option, null: true, foreign_key: true
      t.string :response_text
      t.boolean :is_correct

      t.timestamps
    end
  end
end
