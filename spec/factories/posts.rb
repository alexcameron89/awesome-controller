FactoryBot.define do
  factory :post do
    author
    title { "Hello Stitch Fix!" }
    content { "I can't wait to receive my fix!" }
  end
end
