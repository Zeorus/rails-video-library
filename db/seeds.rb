# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Clean DB genres"
Genre.destroy_all

puts "Create Genres"
Genre.create(name: "Action", tmdb_id: 28)
Genre.create(name: "Aventure", tmdb_id: 12)
Genre.create(name: "Animation", tmdb_id: 16)
Genre.create(name: "Comédie", tmdb_id: 35)
Genre.create(name: "Crime", tmdb_id: 80)
Genre.create(name: "Documentaire", tmdb_id: 99)
Genre.create(name: "Drame", tmdb_id: 18)
Genre.create(name: "Familial", tmdb_id: 10751)
Genre.create(name: "Fantastique", tmdb_id: 14)
Genre.create(name: "Histoire", tmdb_id: 36)
Genre.create(name: "Horreur", tmdb_id: 27)
Genre.create(name: "Musique", tmdb_id: 10402)
Genre.create(name: "Mystère", tmdb_id: 9648)
Genre.create(name: "Romance", tmdb_id: 10749)
Genre.create(name: "Science-Fiction", tmdb_id: 878)
Genre.create(name: "Téléfilm", tmdb_id: 10770)
Genre.create(name: "Thriller", tmdb_id: 53)
Genre.create(name: "Guerre", tmdb_id: 10752)
Genre.create(name: "Western", tmdb_id: 37)

puts "#{Genre.count} genres created!"