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

ActiveRecord::Schema.define(version: 20130919131509) do

  create_table "authors", force: true do |t|
    t.string   "lastname"
    t.string   "firstname"
    t.date     "birthdate"
    t.date     "deathdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.integer  "isbn"
    t.integer  "collection_id"
    t.integer  "publisher_id"
    t.decimal  "price",         precision: 8, scale: 2
    t.date     "release"
    t.string   "title"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["collection_id"], name: "index_books_on_collection_id"
  add_index "books", ["publisher_id"], name: "index_books_on_publisher_id"

  create_table "collections", force: true do |t|
    t.integer  "publisher_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["publisher_id"], name: "index_collections_on_publisher_id"

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

end
