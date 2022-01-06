# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create([
    {email: "andy@email.com", password: "password"},
    {email: "bob@email.com", password: "password"},
    {email: "tom@email.com", password: "password"},
    {email: "sam@email.com", password: "password"}
  ])