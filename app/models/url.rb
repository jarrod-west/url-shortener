class Url < ApplicationRecord
  # TODO: Validations
  attribute :original, :string
  attribute :short, :string

  validates :original, uniqueness: { message: "URL has already been shortened" }
  validates :original, presence: { message: "URL can't be blank" }
end
