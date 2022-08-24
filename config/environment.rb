require 'bundler'
Bundler.require

require_relative '../lib/student'

DB = { conn: SQLite3::Database.new("db/school.db") }

# RUN CODE FROM HERE

Student.create_table

kelvin = Student.new(name:"Kelvin",age:22)
# add student
kelvin.add_to_db
pp Student.all
kelvin.name = "Kevoh"
kelvin.age = 24
kelvin.update

pp Student.all

kelvin.name = "water loo"
kelvin.age= 19
kelvin.add_to_db

pp Student.all

kelvin.delete
