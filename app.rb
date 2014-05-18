require 'sinatra'
require 'mechanize'
require 'google_drive'
require 'open-uri'

configure :development do
  require 'pp'
  require 'dotenv'

  Dotenv.load
end

Session = GoogleDrive.login(ENV['GOOGLE_USER'], ENV['GOOGLE_PASS'])

require_relative 'lib/scanner.rb'
require_relative 'lib/image_scanner.rb'
require_relative 'lib/content_scanner.rb'
require_relative 'lib/content_set.rb'

#Paths
get '/' do
  erb :form
end

post '/form' do
  input=params[:URL1]
  @meta=Scannerset::Scanner.detect(input).pull_data(input)
  if @meta.empty?
  	erb :empty
  else
  	erb :output
  end
end
