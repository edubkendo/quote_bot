require 'sequel'

DB = Sequel.sqlite('db/quotes.db')

DB.create_table :quotes do
  primary_key :id
  String :name
  String :quote_text, :text => true
end
