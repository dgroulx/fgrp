# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Park.create([
	{name: "Ah-Nab-Awen", latitude: 42.9683, longitude: -85.6767, address: "220 Front Ave NW Grand Rapids"},
	{name: "Aberdeen Park", latitude: 43.0045, longitude: -85.6497, address: "Eastern at Evelyn NE Grand Rapids"},
	{name: "Highland Park", latitude: 42.9754, longitude: -85.657, address: "700 College NE Grand Rapids"},
	]);