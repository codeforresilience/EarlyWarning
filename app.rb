# vim: set noet sts=4 sw=4 ts=4 ft=ruby :
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

helpers do
	include Rack::Utils; alias_method :h, :escape_html
end

configure do
end

post '/voices/publish.xml' do

end

get '/voices/receipt.xml' do

end

