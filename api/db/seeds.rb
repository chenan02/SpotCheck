# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Place.create(
    name: "Ugli",
    occupancy: 3.14,
    address: "919 S University Ave, Ann Arbor, MI 48109",
    category: "Library",
    description: "The ugliest library in town"
)
Place.create(
    name: "Rick's",
    occupancy: 4.99,
    address: "South University Galleria Shopping Center, 611 Church St, Ann Arbor, MI 48104",
    category: "Bar",
    description: "Rick's American Cafe - Where Friends Meet!"
)