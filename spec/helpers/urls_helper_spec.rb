# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UrlsHelper. For example:
#
# describe UrlsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UrlHelper, type: :helper do
  describe 'full_shortened' do
    it 'returns the full shortened url' do
      Url.create(original: 'http://www.google.com', short: 'short-url')
      url = Url.find_by(short: 'short-url')

      expect(helper.full_shortened(url)).to eq(URI('http://test.host/short-url'))
    end
  end
end
