# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'GET /urls' do
    it 'renders the index page' do
      get '/urls'

      expect(response.status).to render_template(:index)
    end
  end

  describe 'POST /urls' do
    before do
      allow(SecureRandom).to receive(:urlsafe_base64).with(8).and_return('abcd1234')
    end

    it 'creates a url' do
      post '/urls', params: { url: { original: 'http://www.google.com' } }

      expect(response).to redirect_to(action: 'show', controller: 'urls', short: 'abcd1234', created: true)
    end

    context 'when the save fails' do
      before do
        allow_any_instance_of(Url).to receive(:save).and_return(false)
      end

      it 're-renders the "new" view again' do
        post '/urls', params: { url: { original: 'http://www.google.com' } }

        expect(response.status).to render_template(:new)
      end
    end
  end

  describe 'GET /urls' do
    before do
      allow(SecureRandom).to receive(:urlsafe_base64).with(8).and_return('1234abcd')
      post '/urls', params: { url: { original: 'http://www.google.com' } }
      expect(response).to redirect_to(action: 'show', controller: 'urls', short: '1234abcd', created: true)
    end

    it 'redirects to the original URL' do
      get '/urls/1234abcd'

      expect(response.status).to eq(302)
      expect(response).to redirect_to('http://www.google.com')
    end
  end
end
