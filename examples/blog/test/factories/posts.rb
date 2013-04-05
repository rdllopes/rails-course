# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :post do
    titulo {Faker::Lorem::words.join(" ")}
    conteudo {Faker::Lorem::sentences.join("\n")}
  end
end
