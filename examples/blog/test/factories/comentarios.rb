# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :comentario do
    autor {Faker::Name.name}
    texto {Faker::Lorem::sentences.join("\n")}
  end
end
