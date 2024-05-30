# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  it 'creates the URL' do
    expect(Url.new(original: 'http://www.google.com', short: 'bar')).to be_valid
  end

  it 'uses the short suffix as the ID' do
    url = Url.new(original: 'http://www.google.com', short: 'bar')
    expect(url.to_param).to eq('bar')
  end

  it 'requires the original url to be present' do
    expect(Url.new(short: 'bar')).to_not be_valid
  end

  it 'requires the original url to be in the valid format' do
    expect(Url.new(original: 'htt://www.google.com', short: 'baz')).to_not be_valid
    expect(Url.new(original: 'www.google.com', short: 'zap')).to_not be_valid
  end

  it 'requires the original url to be unique' do
    Url.create(original: 'http://www.google.com')
    expect(Url.new(original: 'http://www.google.com', short: 'baz')).to_not be_valid
  end
end
