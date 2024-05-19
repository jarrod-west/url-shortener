class Url < ApplicationRecord
  # TODO: Validations
  attribute :original, :string
  attribute :short, :string

  validates :original, uniqueness: true
end
