# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140125171125) do

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "boxes", force: true do |t|
    t.integer "number"
    t.integer "unit_advance_id"
  end

  add_index "boxes", ["number"], name: "index_boxes_on_number", using: :btree
  add_index "boxes", ["unit_advance_id"], name: "index_boxes_on_unit_advance_id", using: :btree

  create_table "course_translations", force: true do |t|
    t.integer  "course_id",   null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "short"
    t.text     "description"
  end

  add_index "course_translations", ["course_id"], name: "index_course_translations_on_course_id", using: :btree
  add_index "course_translations", ["locale"], name: "index_course_translations_on_locale", using: :btree

  create_table "courses", force: true do |t|
    t.string  "slug"
    t.boolean "published", default: false
  end

  add_index "courses", ["slug"], name: "index_courses_on_slug", unique: true, using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "email_confirmations", force: true do |t|
    t.integer  "user_id"
    t.string   "new_email"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "email_confirmations", ["new_email"], name: "index_email_confirmations_on_new_email", using: :btree
  add_index "email_confirmations", ["token"], name: "index_email_confirmations_on_token", unique: true, using: :btree
  add_index "email_confirmations", ["user_id"], name: "index_email_confirmations_on_user_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.text     "message"
    t.string   "contact_info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "latest_content_translations", force: true do |t|
    t.integer  "latest_content_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
  end

  add_index "latest_content_translations", ["latest_content_id"], name: "index_latest_content_translations_on_latest_content_id", using: :btree
  add_index "latest_content_translations", ["locale"], name: "index_latest_content_translations_on_locale", using: :btree

  create_table "latest_contents", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "released_at"
  end

  add_index "latest_contents", ["owner_id", "owner_type"], name: "index_latest_contents_on_owner_id_and_owner_type", using: :btree
  add_index "latest_contents", ["released_at"], name: "index_latest_contents_on_released_at", using: :btree

  create_table "page_translations", force: true do |t|
    t.integer  "page_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "short"
    t.text     "content"
  end

  add_index "page_translations", ["locale"], name: "index_page_translations_on_locale", using: :btree
  add_index "page_translations", ["page_id"], name: "index_page_translations_on_page_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_image"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "redactor_assets", force: true do |t|
    t.integer  "user_id"
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], name: "idx_redactor_assetable", using: :btree
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_redactor_assetable_type", using: :btree

  create_table "role_appointments", force: true do |t|
    t.integer "user_id"
    t.string  "role_id"
  end

  add_index "role_appointments", ["role_id", "user_id"], name: "index_role_appointments_on_role_id_and_user_id", using: :btree

  create_table "sitemplate_core_metatags_sets", force: true do |t|
    t.text    "keywords"
    t.integer "owner_id"
    t.string  "owner_type"
    t.text    "description"
  end

  add_index "sitemplate_core_metatags_sets", ["owner_id", "owner_type"], name: "index_sitemplate_core_metatags_sets_on_owner_id_and_owner_type", using: :btree

  create_table "sitemplate_core_settings", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sitemplate_core_settings", ["category"], name: "index_sitemplate_core_settings_on_category", using: :btree
  add_index "sitemplate_core_settings", ["key", "category"], name: "index_sitemplate_core_settings_on_key_and_category", unique: true, using: :btree
  add_index "sitemplate_core_settings", ["key"], name: "index_sitemplate_core_settings_on_key", using: :btree

  create_table "step_box_mappings", force: true do |t|
    t.integer "box_id"
    t.integer "step_id"
  end

  add_index "step_box_mappings", ["box_id"], name: "index_step_box_mappings_on_box_id", using: :btree
  add_index "step_box_mappings", ["step_id"], name: "index_step_box_mappings_on_step_id", using: :btree

  create_table "step_mappings", force: true do |t|
    t.integer "unit_id"
    t.integer "step_id"
    t.integer "position"
    t.boolean "from_en",  default: true
    t.boolean "to_en",    default: true
    t.boolean "from_ru",  default: true
    t.boolean "to_ru",    default: true
    t.boolean "from_es",  default: true
    t.boolean "to_es",    default: true
  end

  add_index "step_mappings", ["position"], name: "index_step_mappings_on_position", using: :btree
  add_index "step_mappings", ["step_id"], name: "index_step_mappings_on_step_id", using: :btree
  add_index "step_mappings", ["unit_id"], name: "index_step_mappings_on_unit_id", using: :btree

  create_table "steps", force: true do |t|
    t.string "en"
    t.string "en_regexp"
    t.string "ru"
    t.string "ru_regexp"
    t.text   "shared_template"
    t.string "es"
    t.string "es_regexp"
    t.text   "ru_template"
    t.text   "en_template"
    t.text   "es_template"
  end

  create_table "unit_advances", force: true do |t|
    t.integer  "user_id"
    t.integer  "unit_id",                              null: false
    t.integer  "language_id",                          null: false
    t.integer  "steps_passed",         default: 0
    t.integer  "words_helped",         default: 0
    t.integer  "steps_helped",         default: 0
    t.integer  "right_answers",        default: 0
    t.integer  "wrong_answers",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.string   "session_token"
    t.text     "steps"
    t.integer  "current_step",         default: 0
    t.boolean  "revised",              default: false
    t.integer  "revised_steps_number", default: 0
    t.integer  "native_language_id"
  end

  add_index "unit_advances", ["date"], name: "index_unit_advances_on_date", using: :btree
  add_index "unit_advances", ["native_language_id"], name: "index_unit_advances_on_native_language_id", using: :btree
  add_index "unit_advances", ["revised"], name: "index_unit_advances_on_revised", using: :btree
  add_index "unit_advances", ["session_token"], name: "index_unit_advances_on_session_token", using: :btree
  add_index "unit_advances", ["unit_id"], name: "index_unit_advances_on_unit_id", using: :btree
  add_index "unit_advances", ["user_id"], name: "index_unit_advances_on_user_id", using: :btree

  create_table "unit_translations", force: true do |t|
    t.integer  "unit_id",     null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
  end

  add_index "unit_translations", ["locale"], name: "index_unit_translations_on_locale", using: :btree
  add_index "unit_translations", ["unit_id"], name: "index_unit_translations_on_unit_id", using: :btree

  create_table "units", force: true do |t|
    t.string  "slug"
    t.boolean "random_steps_order", default: false
    t.boolean "free",               default: true
    t.integer "course_id"
    t.boolean "published",          default: false
  end

  add_index "units", ["course_id"], name: "index_units_on_course_id", using: :btree
  add_index "units", ["slug", "course_id"], name: "index_units_on_slug_and_course_id", unique: true, using: :btree

  create_table "useful_link_translations", force: true do |t|
    t.integer  "useful_link_id", null: false
    t.string   "locale",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "description"
  end

  add_index "useful_link_translations", ["locale"], name: "index_useful_link_translations_on_locale", using: :btree
  add_index "useful_link_translations", ["useful_link_id"], name: "index_useful_link_translations_on_useful_link_id", using: :btree

  create_table "useful_links", force: true do |t|
    t.string "url"
    t.string "source"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "language_id"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
