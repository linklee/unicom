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

ActiveRecord::Schema.define(version: 20170119191159) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "fact_locality_name"
    t.string   "fact_street"
    t.string   "reg_house"
    t.string   "fact_flat"
    t.boolean  "same_address"
    t.string   "reg_locality_name"
    t.string   "reg_street"
    t.string   "reg_flat"
    t.string   "surname"
    t.string   "name"
    t.string   "patronymic"
    t.string   "mobile_phone"
    t.string   "email"
    t.string   "desired_amount"
    t.boolean  "agree_rules"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "fact_city"
    t.string   "fact_house"
    t.string   "reg_city"
    t.integer  "locality_id"
    t.integer  "app_id"
    t.string   "passport_code"
    t.date     "passport_date"
    t.date     "birth_date"
    t.string   "birth_place"
    t.text     "response"
    t.integer  "fact_locality_id"
    t.string   "status"
    t.integer  "partner_id"
    t.integer  "offer_id"
  end

end
