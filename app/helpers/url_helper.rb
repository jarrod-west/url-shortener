module UrlHelper
  def full_shortened(url)
    url_for [@url, short: @url.short, only_path: false]
  end
end
