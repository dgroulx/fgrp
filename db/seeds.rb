# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env != "production"
  User.destroy_all
  User.create(email: "admin@fgrp.org", password: "password", password_confirmation: "password", admin: true)
  User.create(email: "user@fgrp.org", password: "password", password_confirmation: "password")

	Park.destroy_all
	Park.create([
		{name: "Ah-Nab-Awen", latitude: 42.9683, longitude: -85.6767, address: "220 Front Ave NW Grand Rapids", flickr_pool: "1290983@N23" },
		{name: "Aberdeen Park", latitude: 43.0045, longitude: -85.6497, address: "Eastern at Evelyn NE Grand Rapids", flickr_pool: "1238780@N25"},
		{name: "Highland Park", latitude: 42.9754, longitude: -85.657, address: "700 College NE Grand Rapids"},
		])
  aberdeen = Park.find_by_name("Aberdeen Park")

  Fact.destroy_all
  Fact.create([
    {question: "Largest City Park", answer: "Aman Park, 331 acers"},
    {question: "Smallet City Park", answer: "Sundial Park, 0.005 acers"},
    {question: "First Park Bond", answer: "1911, adding 180 acers"},
    {question: "Newest Playground", answer: "Aberdeen Park"},
    {question: "Number of Basketball Courts", answer: "58"},
    {question: "Most Common Street Tree", answer: "Norway Maple"}
    ])

  google = ParkLink.create(name: "Google", url: "http://www.google.com")
  aberdeen.links << google
end
