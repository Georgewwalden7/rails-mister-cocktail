# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

url = 'https://raw.githubusercontent.com/teijo/iba-cocktails/master/recipes.json'
user_serialized = open(url).read
user = JSON.parse(user_serialized)

user.each do |item|
  new_cocktail = Cocktail.create!(
    name: item['name'],
    preparation: item['preparation']
  )
  item['ingredients'].each do |dose|
    if dose['unit'].nil?
      new_cocktail.tags << dose['special']
      new_cocktail.save
    else
      new_dose = Dose.new(description: "#{dose['amount']} #{dose['unit'].upcase}")
      new_dose.label = dose['label'] if !dose['label'].nil?
      new_ingredient = Ingredient.new(name: dose['ingredient'])
      if new_ingredient.save
        new_dose.ingredient = new_ingredient
        new_dose.cocktail = new_cocktail
        new_dose.save
      else
        new_dose.ingredient = Ingredient.find_by_name(dose['ingredient'])
        new_dose.cocktail = new_cocktail
        if new_dose.valid?
          new_dose.save
        else
          p "Found ingredient"
          p new_ingredient
          p new_dose
        end
      end
    end
  end
end
