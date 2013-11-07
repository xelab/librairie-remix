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

ActiveRecord::Schema.define(version: 20131107151405) do

  create_table "authors", force: true do |t|
    t.string   "lastname"
    t.string   "firstname"
    t.date     "birthdate"
    t.date     "deathdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors_books", id: false, force: true do |t|
    t.integer "author_id", null: false
    t.integer "book_id",   null: false
  end

  add_index "authors_books", ["author_id", "book_id"], name: "index_authors_books_on_author_id_and_book_id", using: :btree
  add_index "authors_books", ["book_id", "author_id"], name: "index_authors_books_on_book_id_and_author_id", using: :btree

  create_table "books", force: true do |t|
    t.decimal  "isbn",           precision: 64, scale: 0
    t.integer  "collection_id"
    t.integer  "publisher_id"
    t.decimal  "price",          precision: 8,  scale: 2
    t.date     "release"
    t.string   "title"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deposit"
    t.integer  "buy"
    t.integer  "distributor_id"
  end

  add_index "books", ["collection_id"], name: "index_books_on_collection_id", using: :btree
  add_index "books", ["distributor_id"], name: "index_books_on_distributor_id", using: :btree
  add_index "books", ["publisher_id"], name: "index_books_on_publisher_id", using: :btree

  create_table "books_tags", id: false, force: true do |t|
    t.integer "book_id", null: false
    t.integer "tag_id",  null: false
  end

  add_index "books_tags", ["book_id", "tag_id"], name: "index_books_tags_on_book_id_and_tag_id", using: :btree
  add_index "books_tags", ["tag_id", "book_id"], name: "index_books_tags_on_tag_id_and_book_id", using: :btree

  create_table "collections", force: true do |t|
    t.integer  "publisher_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["publisher_id"], name: "index_collections_on_publisher_id", using: :btree

  create_table "distributors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "address"
    t.string   "city"
    t.string   "zip"
    t.string   "phone"
    t.string   "mail"
  end

  create_table "publishers", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "city"
    t.string   "zip"
    t.string   "phone"
    t.string   "mail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", force: true do |t|
    t.integer  "book_id"
    t.integer  "buy_quantity"
    t.integer  "deposit_quantity"
    t.decimal  "price",            precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sales", ["book_id"], name: "index_sales_on_book_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
