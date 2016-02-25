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

ActiveRecord::Schema.define(version: 20160222105312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_genres", force: :cascade do |t|
    t.integer  "genre_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "book_genres", ["book_id"], name: "index_book_genres_on_book_id", using: :btree
  add_index "book_genres", ["genre_id"], name: "index_book_genres_on_genre_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.string   "author"
    t.string   "picture"
    t.text     "context"
    t.boolean  "is_draft"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "books", ["user_id"], name: "index_books_on_user_id", using: :btree

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "quote_likes", force: :cascade do |t|
    t.integer  "quote_id"
    t.integer  "like_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "quote_likes", ["like_id"], name: "index_quote_likes_on_like_id", using: :btree
  add_index "quote_likes", ["quote_id"], name: "index_quote_likes_on_quote_id", using: :btree

  create_table "quotes", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "quotes", ["book_id"], name: "index_quotes_on_book_id", using: :btree
  add_index "quotes", ["user_id"], name: "index_quotes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "book_genres", "books"
  add_foreign_key "book_genres", "genres"
  add_foreign_key "books", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "quote_likes", "likes"
  add_foreign_key "quote_likes", "quotes"
  add_foreign_key "quotes", "books"
  add_foreign_key "quotes", "users"
end
