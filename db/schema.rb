# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110917161107) do

  create_table "accounts", :force => true do |t|
    t.string  "account_number",    :limit => 20,                                :default => "", :null => false
    t.decimal "discount",                         :precision => 8, :scale => 3
    t.string  "account_type",      :limit => 20
    t.string  "company_name",      :limit => 100
    t.string  "contact_name",      :limit => 100
    t.string  "address_line1",     :limit => 100
    t.string  "address_line2",     :limit => 100
    t.string  "city",              :limit => 100
    t.string  "state_or_province", :limit => 2
    t.string  "postal_code",       :limit => 20
    t.string  "telephone_number",  :limit => 20
    t.string  "fax_number",        :limit => 10
    t.string  "email_address",     :limit => 50
    t.string  "user",              :limit => 80
    t.string  "password",          :limit => 80
  end

  create_table "app_settings", :force => true do |t|
    t.string "name",  :limit => 20
    t.string "value", :limit => 80
  end

  create_table "categories", :force => true do |t|
    t.string "name", :limit => 80
  end

  create_table "common_codes", :force => true do |t|
    t.string "code_id",    :limit => 30
    t.string "code_value", :limit => 80
    t.string "code_type",  :limit => 30
  end

  create_table "customer_items", :force => true do |t|
    t.string "account_id", :limit => 20, :default => "", :null => false
    t.string "product_id", :limit => 20, :default => "", :null => false
    t.date   "add_date"
  end

  create_table "descriptions", :force => true do |t|
    t.integer "product_id",    :limit => 2
    t.string  "part_number",   :limit => 20
    t.string  "description",   :limit => 2000
    t.string  "language_code", :limit => 2
  end

  add_index "descriptions", ["product_id"], :name => "product_id"

  create_table "families", :force => true do |t|
    t.string "name",         :limit => 100
    t.string "mfg_code",     :limit => 100
    t.string "kbcores_code", :limit => 100
    t.string "year_range",   :limit => 100
    t.text   "notes"
    t.string "group_code",   :limit => 100
  end

  create_table "family_groups", :force => true do |t|
    t.string "make_code",  :limit => 10
    t.string "fg_type",    :limit => 20
    t.string "group_code", :limit => 100
    t.string "group_name", :limit => 100
  end

  create_table "invoice_details", :force => true do |t|
    t.string  "invoice_number",  :limit => 20, :default => "", :null => false
    t.string  "part_number",     :limit => 20
    t.integer "qty_ordered"
    t.integer "qty_shipped"
    t.integer "qty_backordered"
  end

  create_table "invoices", :force => true do |t|
    t.string "invoice_number",             :limit => 20,  :default => "", :null => false
    t.string "invoice_date",               :limit => 10
    t.string "account_number",             :limit => 20
    t.string "cust_ship_to_address_line1", :limit => 100
    t.string "cust_ship_to_address_line2", :limit => 100
    t.string "city",                       :limit => 100
    t.string "state_or_province",          :limit => 2
    t.string "postal_code",                :limit => 20
    t.string "telephone_number",           :limit => 10
  end

  create_table "lv", :force => true do |t|
    t.integer "LEGACYVEHICLEID",               :default => 0,  :null => false
    t.string  "YEAR",            :limit => 4,  :default => "", :null => false
    t.string  "MAKE",            :limit => 50, :default => "", :null => false
    t.string  "MODEL",           :limit => 50, :default => "", :null => false
    t.string  "SUBMODEL",        :limit => 50, :default => "", :null => false
    t.integer "ENGINELEGACYID",                :default => 0,  :null => false
    t.string  "COUNTRY",         :limit => 10, :default => "", :null => false
  end

  create_table "make", :primary_key => "MAKENAME", :force => true do |t|
  end

  create_table "make_codes", :force => true do |t|
    t.string "name", :limit => 100
    t.string "code", :limit => 10
  end

  create_table "makes", :force => true do |t|
    t.string "name",        :limit => 100
    t.string "parent_name", :limit => 100
    t.string "parent_code", :limit => 10
  end

  create_table "model", :primary_key => "MODELNAME", :force => true do |t|
  end

  create_table "news_items", :force => true do |t|
    t.text   "title"
    t.text   "text"
    t.date   "create_date"
    t.string "link_in_ticker", :limit => 1, :default => "N"
  end

  create_table "parts", :force => true do |t|
    t.string  "part_no",              :limit => 20
    t.string  "part_type",            :limit => 20
    t.string  "part_category",        :limit => 20
    t.string  "description",          :limit => 2000
    t.string  "manufacturer",         :limit => 80
    t.string  "cylinders",            :limit => 80
    t.string  "liters",               :limit => 80
    t.string  "ccs",                  :limit => 80
    t.string  "stroke",               :limit => 20
    t.string  "rod",                  :limit => 20
    t.string  "main",                 :limit => 20
    t.string  "front_seal_dia",       :limit => 20
    t.string  "rear_seal_dia",        :limit => 20
    t.string  "bore",                 :limit => 20
    t.string  "connect_rod_len",      :limit => 20
    t.string  "camshaft",             :limit => 20
    t.string  "valves",               :limit => 20
    t.string  "casting_no",           :limit => 80
    t.string  "trans_speed",          :limit => 20
    t.string  "trans_type",           :limit => 20
    t.string  "notes",                :limit => 2000
    t.integer "application_start_yr"
    t.integer "application_end_yr"
    t.string  "metal",                :limit => 20
    t.string  "kb_product_code",      :limit => 20
    t.string  "on_hand",              :limit => 20
    t.string  "price",                :limit => 20
  end

  add_index "parts", ["part_category"], :name => "idx_part_category"
  add_index "parts", ["part_no"], :name => "idx_part_no", :unique => true
  add_index "parts", ["part_type"], :name => "part_type"

  create_table "pictures", :force => true do |t|
    t.text   "comment"
    t.string "name"
    t.string "content_type", :limit => 100
    t.binary "data",         :limit => 2147483647
  end

  add_index "pictures", ["name"], :name => "idx_picture_name"

  create_table "product_applications", :force => true do |t|
    t.integer "product_id",      :limit => 2
    t.string  "part_number",     :limit => 20
    t.string  "base_vehicle_id", :limit => 10
    t.string  "submodel_id",     :limit => 80
    t.string  "aaia_id",         :limit => 10
    t.string  "year",            :limit => 4
    t.string  "make",            :limit => 80
    t.string  "model",           :limit => 80
  end

  create_table "product_categories", :force => true do |t|
    t.integer "product_id",  :limit => 2
    t.integer "category_id", :limit => 2
  end

  create_table "product_pictures", :force => true do |t|
    t.integer "product_id", :limit => 2
    t.integer "picture_id", :limit => 2
    t.string  "rel_type",   :limit => 80
  end

  create_table "product_types", :force => true do |t|
    t.string "name", :limit => 80
  end

  create_table "products", :force => true do |t|
    t.string  "part_number",    :limit => 20
    t.string  "product_type",   :limit => 80
    t.string  "mfr",            :limit => 80
    t.string  "family",         :limit => 80
    t.string  "display_group",  :limit => 20
    t.integer "display_order",  :limit => 2
    t.integer "level_1_qty",    :limit => 2
    t.string  "level_1_lot",    :limit => 10
    t.decimal "level_1_price",                :precision => 8, :scale => 2
    t.decimal "level_1_core",                 :precision => 8, :scale => 2
    t.integer "level_2_qty",    :limit => 2
    t.string  "level_2_lot",    :limit => 10
    t.decimal "level_2_price",                :precision => 8, :scale => 2
    t.decimal "level_2_core",                 :precision => 8, :scale => 2
    t.integer "level_3_qty",    :limit => 2
    t.string  "level_3_lot",    :limit => 10
    t.decimal "level_3_price",                :precision => 8, :scale => 2
    t.decimal "level_3_core",                 :precision => 8, :scale => 2
    t.integer "level_4_qty",    :limit => 2
    t.string  "level_4_lot",    :limit => 10
    t.decimal "level_4_price",                :precision => 8, :scale => 2
    t.decimal "level_4_core",                 :precision => 8, :scale => 2
    t.integer "level_5_qty",    :limit => 2
    t.string  "level_5_lot",    :limit => 10
    t.decimal "level_5_price",                :precision => 8, :scale => 2
    t.decimal "level_5_core",                 :precision => 8, :scale => 2
    t.integer "level_6_qty",    :limit => 2
    t.string  "level_6_lot",    :limit => 10
    t.decimal "level_6_price",                :precision => 8, :scale => 2
    t.decimal "level_6_core",                 :precision => 8, :scale => 2
    t.integer "level_7_qty",    :limit => 2
    t.string  "level_7_lot",    :limit => 10
    t.decimal "level_7_price",                :precision => 8, :scale => 2
    t.decimal "level_7_core",                 :precision => 8, :scale => 2
    t.integer "level_8_qty",    :limit => 2
    t.string  "level_8_lot",    :limit => 10
    t.decimal "level_8_price",                :precision => 8, :scale => 2
    t.decimal "level_8_core",                 :precision => 8, :scale => 2
    t.integer "level_9_qty",    :limit => 2
    t.string  "level_9_lot",    :limit => 10
    t.decimal "level_9_price",                :precision => 8, :scale => 2
    t.decimal "level_9_core",                 :precision => 8, :scale => 2
    t.text    "notes"
    t.string  "classification", :limit => 80
    t.integer "app_start_year"
    t.integer "app_end_year"
    t.string  "make",           :limit => 80
    t.string  "metal",          :limit => 80
    t.string  "cylinders",      :limit => 80
    t.string  "cid",            :limit => 80
    t.string  "liters",         :limit => 20
    t.string  "product_code",   :limit => 80
    t.string  "on_hand",        :limit => 80,                               :default => "Call for inventory"
  end

  add_index "products", ["classification"], :name => "classification"
  add_index "products", ["family"], :name => "family"
  add_index "products", ["family"], :name => "family_2"
  add_index "products", ["mfr"], :name => "mfr"
  add_index "products", ["mfr"], :name => "mfr_2"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tracking", :force => true do |t|
    t.string "ip_address",  :limit => 20, :default => ""
    t.string "user_id",     :limit => 50
    t.string "page_name",   :limit => 50
    t.string "part_number", :limit => 20
    t.date   "create_date"
    t.string "City",        :limit => 80
    t.string "Region",      :limit => 80
    t.string "Country",     :limit => 80
  end

  add_index "tracking", ["create_date"], :name => "IDX_1"
  add_index "tracking", ["ip_address"], :name => "IDX_2"
  add_index "tracking", ["page_name"], :name => "IDX_4"
  add_index "tracking", ["part_number"], :name => "IDX_5"
  add_index "tracking", ["user_id"], :name => "IDX_3"

  create_table "users", :force => true do |t|
    t.string "user_id",    :limit => 20, :default => "", :null => false
    t.string "password",   :limit => 20, :default => "", :null => false
    t.string "last_name",  :limit => 80, :default => ""
    t.string "first_name", :limit => 80, :default => ""
  end

  create_table "year", :primary_key => "YEARID", :force => true do |t|
  end

end
