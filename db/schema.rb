# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_12_05_114309) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.bigint "question_id", null: false
    t.bigint "option_id"
    t.string "response_text"
    t.boolean "is_correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_answers_on_option_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["submission_id"], name: "index_answers_on_submission_id"
  end

  create_table "options", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "text", null: false
    t.boolean "is_correct", default: false, null: false
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id", "position"], name: "index_options_on_question_id_and_position"
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.text "prompt", null: false
    t.string "question_type", null: false
    t.integer "position", default: 0
    t.integer "points", default: 1, null: false
    t.string "correct_answer"
    t.text "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id", "position"], name: "index_questions_on_quiz_id_and_position"
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "slug", null: false
    t.boolean "published", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_quizzes_on_slug", unique: true
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.integer "score", default: 0, null: false
    t.integer "total_points", null: false
    t.datetime "submitted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_submissions_on_quiz_id"
  end

  add_foreign_key "answers", "options"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "submissions"
  add_foreign_key "options", "questions"
  add_foreign_key "questions", "quizzes"
  add_foreign_key "submissions", "quizzes"
end
