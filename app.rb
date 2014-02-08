# vim: set noet sts=4 sw=4 ts=4 ft=ruby :

require 'json'

require 'rubygems'
require 'pit'
require 'twilio-ruby'
require 'sinatra'
require 'sinatra/reloader'

require 'mongoid'
Mongoid.load!('mongoid.yml', :development)
require_relative './models/account'

config = Pit.get('twilio',
				 :require => {
	'sid'   => 'twilio sid',
	'token' => 'twilio auth token',
	'from' => 'twilio from phone number',
})

$twilio = Twilio::REST::Client.new(config['sid'], config['token'])
$from_phone_number = config['from']

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
	center = [params['lat'], params['lon']]
	distance = params['radius']
	Account.each_near(center, distance) do |a|
		to =a['phone_number']
		url = 'http://ewsb.no32.tk/voices/publish.xml'
		a.call($twilio, $from_phone_number, to, url)
		break
	end
	'It works!'
end

