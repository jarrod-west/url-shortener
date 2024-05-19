class UrlFormatValidator < ActiveModel::Validator

  def validate(url_record)
    unless url_record.original =~ /\A#{URI::regexp(['http', 'https'])}\z/
      url_record.errors.add :original, "Not a valid URL"
    end
  end
end