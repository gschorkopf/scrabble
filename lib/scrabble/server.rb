module Scrabble
  class Server < Sinatra::Base
    set :views, 'lib/scrabble/views'

    get '/' do
      @words = Word.all
      erb :index
    end

    post '/create' do
      word = Word.new(params['word'])
      word.save
      redirect to('/')
    end

    not_found do
      erb :error
    end

  end
end