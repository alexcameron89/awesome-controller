class Post < ApplicationRecord
  belongs_to :author, optional: true
end
