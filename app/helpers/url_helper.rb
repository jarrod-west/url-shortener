# frozen_string_literal: true

module UrlHelper
  def full_shortened(url_object)
    url_for [url_object, { only_path: false }]
  end
end
