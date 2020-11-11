# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_11_144904) do

  create_table "achievements", force: :cascade do |t|
    t.string "description"
    t.string "badge_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "neighborhood"
    t.string "number"
    t.string "state"
    t.string "city"
    t.integer "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "latitude"
    t.string "longitude"
    t.index ["unit_id"], name: "index_addresses_on_unit_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hit"
    t.integer "student_id"
    t.integer "question_id"
    t.index ["question_id"], name: "index_attempts_on_question_id"
    t.index ["student_id"], name: "index_attempts_on_student_id"
  end

  create_table "audio_versions", force: :cascade do |t|
    t.string "title"
    t.integer "level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_audio_versions_on_level_id"
  end

  create_table "audios", force: :cascade do |t|
    t.string "title"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level_id"
    t.integer "audio_version_id"
    t.index ["audio_version_id"], name: "index_audios_on_audio_version_id"
    t.index ["level_id"], name: "index_audios_on_level_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "attachment"
    t.string "cover"
    t.boolean "downloadable"
    t.integer "level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_books_on_level_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language"
    t.integer "unit_id"
    t.string "course_flag"
    t.text "description", default: ""
    t.boolean "published"
    t.string "cover"
    t.string "inner"
    t.string "site_flag"
    t.integer "order"
    t.integer "course_id"
    t.index ["course_id"], name: "index_courses_on_course_id"
    t.index ["unit_id"], name: "index_courses_on_unit_id"
  end

  create_table "discount_messages", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "telefone"
    t.string "unidade"
    t.string "curso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "errolments", force: :cascade do |t|
    t.integer "student_id"
    t.integer "level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.date "expiration"
    t.index ["level_id"], name: "index_errolments_on_level_id"
    t.index ["student_id"], name: "index_errolments_on_student_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "title"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level_id"
    t.index ["level_id"], name: "index_exams_on_level_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "galleries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "images"
  end

  create_table "instructions", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.index ["course_id"], name: "index_levels_on_course_id"
  end

  create_table "login_activities", force: :cascade do |t|
    t.string "scope"
    t.string "strategy"
    t.string "identity"
    t.boolean "success"
    t.string "failure_reason"
    t.string "user_type"
    t.integer "user_id"
    t.string "context"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "city"
    t.string "region"
    t.string "country"
    t.datetime "created_at"
    t.index ["identity"], name: "index_login_activities_on_identity"
    t.index ["ip"], name: "index_login_activities_on_ip"
    t.index ["user_type", "user_id"], name: "index_login_activities_on_user_type_and_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "telefone"
    t.string "unidade"
    t.string "assunto"
    t.text "corpo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "curso"
  end

  create_table "pages", force: :cascade do |t|
    t.text "body"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "paths", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level_id"
    t.index ["level_id"], name: "index_paths_on_level_id"
  end

  create_table "post_categories", force: :cascade do |t|
    t.integer "post_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_post_categories_on_category_id"
    t.index ["post_id"], name: "index_post_categories_on_post_id"
  end

  create_table "post_tags", force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_tags_on_post_id"
    t.index ["tag_id"], name: "index_post_tags_on_tag_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "slug"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "question_answers", force: :cascade do |t|
    t.string "question"
    t.text "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_combinations", force: :cascade do |t|
    t.string "label"
    t.string "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id"
    t.index ["question_id"], name: "index_question_combinations_on_question_id"
  end

  create_table "question_errors", force: :cascade do |t|
    t.integer "student_id"
    t.integer "question_id"
    t.string "description", default: "Sem descrição"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_errors_on_question_id"
    t.index ["student_id"], name: "index_question_errors_on_student_id"
  end

  create_table "question_options", force: :cascade do |t|
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "option_description"
    t.boolean "correct"
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "question_texts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id"
    t.string "student_answer"
    t.index ["question_id"], name: "index_question_texts_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "order"
    t.string "description"
    t.integer "path_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "type_question"
    t.string "attachment"
    t.integer "weekly_challenge_bank_question_id"
    t.index ["path_id"], name: "index_questions_on_path_id"
    t.index ["weekly_challenge_bank_question_id"], name: "index_questions_on_weekly_challenge_bank_question_id"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id"
    t.integer "quiz_id"
    t.integer "order"
    t.index ["question_id"], name: "index_quiz_questions_on_question_id"
    t.index ["quiz_id"], name: "index_quiz_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer "student_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_option_id"
    t.string "question_text"
    t.integer "path_id"
    t.index ["path_id"], name: "index_quizzes_on_path_id"
    t.index ["question_id"], name: "index_quizzes_on_question_id"
    t.index ["question_option_id"], name: "index_quizzes_on_question_option_id"
    t.index ["student_id"], name: "index_quizzes_on_student_id"
  end

  create_table "student_achievements", force: :cascade do |t|
    t.integer "student_id"
    t.integer "achievement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id"], name: "index_student_achievements_on_achievement_id"
    t.index ["student_id"], name: "index_student_achievements_on_student_id"
  end

  create_table "student_books", force: :cascade do |t|
    t.integer "current_page"
    t.integer "book_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_student_books_on_book_id"
    t.index ["student_id"], name: "index_student_books_on_student_id"
  end

  create_table "student_instructions", force: :cascade do |t|
    t.boolean "read"
    t.integer "instruction_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instruction_id"], name: "index_student_instructions_on_instruction_id"
    t.index ["student_id"], name: "index_student_instructions_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit_id"
    t.integer "points"
    t.string "phone"
    t.date "birthday"
    t.string "student_avatar"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "pratice_points"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
    t.index ["unit_id"], name: "index_students_on_unit_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "location", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.string "site"
    t.string "phone"
    t.boolean "published"
    t.json "images"
    t.string "slug"
    t.string "cover"
    t.string "email_message"
    t.boolean "manager"
    t.index ["email"], name: "index_units_on_email", unique: true
    t.index ["reset_password_token"], name: "index_units_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_units_on_slug", unique: true
  end

  create_table "weekly_challenge_bank_questions", force: :cascade do |t|
    t.string "title"
    t.integer "level_id"
    t.index ["level_id"], name: "index_weekly_challenge_bank_questions_on_level_id"
  end

  create_table "weekly_challenge_quizzes", force: :cascade do |t|
    t.integer "student_id"
    t.integer "weekly_challenge_id"
    t.boolean "hit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_weekly_challenge_quizzes_on_student_id"
    t.index ["weekly_challenge_id"], name: "index_weekly_challenge_quizzes_on_weekly_challenge_id"
  end

  create_table "weekly_challenges", force: :cascade do |t|
    t.integer "question_id"
    t.date "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level_id"
    t.index ["level_id"], name: "index_weekly_challenges_on_level_id"
    t.index ["question_id"], name: "index_weekly_challenges_on_question_id"
  end

end
