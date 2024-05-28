# frozen_string_literal: true

class Url < ApplicationRecord
  attribute :original, :string
  attribute :short, :string

  validates :original, uniqueness: { message: 'URL has already been shortened' },
                       presence: { message: "URL can't be blank" }, url_format: true

  validates :short, uniqueness: { message: 'Shortened URL already exists' }

  # Use the shortened URL as the ID
  def to_param
    short
  end
end
