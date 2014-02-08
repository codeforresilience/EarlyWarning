# vim: set noet sts=4 sw=4 ts=4 ft=ruby :

require 'json'

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

require 'mongoid'
Mongoid.load!('mongoid.yml', :development)
require_relative './models/account'

helpers do
	include Rack::Utils; alias_method :h, :escape_html
end

configure do
	set :public_folder, File.dirname(__FILE__) + '/static'
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
	Account.all().each do |a|
		p a
	end
	'It works!'
end

