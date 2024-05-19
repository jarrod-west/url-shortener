class UrlFormatValidator < ActiveModel::Validator
  def validate(url_record)
    return if url_record.original =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/

    url_record.errors.add :original, 'Not a valid URL'
  end
end
