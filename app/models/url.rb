class Url < ApplicationRecord
  attribute :original, :string
  attribute :short, :string

  validates :original, uniqueness: { message: "URL has already been shortened" }, presence: { message: "URL can't be blank" }, url_format: true
end
