# vim: set noet sts=4 sw=4 ts=4 ft=ruby :

require 'json'

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

helpers do
	include Rack::Utils; alias_method :h, :escape_html
end

set :public_folder, File.dirname(__FILE__) + '/static'

configure do
end

post '/voices/publish.xml' do
	content_type 'text/xml'
	erb :publish
end

get '/voices/receipt.xml' do
	content_type 'text/xml'
	erb :receipt
end

post '/publish' do
	headers 'Access-Control-Allow-Origin' => '*'
	request.body.rewind
	params = JSON.parse request.body.read
	p params
	'It works!'
end

