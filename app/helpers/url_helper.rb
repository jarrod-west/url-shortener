# frozen_string_literal: true

module UrlHelper
  def full_shortened(url_object)
    URI.join(root_url, url_object.short)
  end
end
