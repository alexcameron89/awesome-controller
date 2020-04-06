FactoryBot.define do
  factory :post do
    author
    title { "Hello!" }
    content { "How are you today?" }
  end
end
