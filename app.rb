# vim: set noet sts=4 sw=4 ts=4 ft=ruby :

require 'json'
require 'socket'

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
	erb :publish, :locals => {
		:message => params['message']
	}
end

post '/voices/receipt.xml' do
	content_type 'text/xml'
	erb :receipt, :locals => {
        :hostname => Socket.gethostname
    }
end

post '/voices/location.xml' do
	content_type 'text/xml'
    p params
    d = params['Digits'].to_i
    d = 5 if 5 < d
    erb :location, :locals => {
        :hostname => Socket.gethostname,
        :division => d
    }
end

post '/voices/:division/receipt_finish.xml' do
	content_type 'text/xml'
    p params
    city = params['Digits'].to_i
    division = params['division'].to_i
    p "===================="
    p division
    p city
    p "===================="
    erb :receipt_finish, :locals => {
        :hostname => Socket.gethostname
    }
end

post '/publish' do
	headers 'Access-Control-Allow-Origin' => '*'
	request.body.rewind
	params = JSON.parse request.body.read
	center = [params['lat'], params['lon']]
	distance = params['radius']
	Account.each_near(center, distance) do |a|
		to =a['phone_number']
		url = 'http://ewsb.no32.tk/voices/publish.xml' +
			"?message=#{CGI.escape params['message']}"
		a.call($twilio, $from_phone_number, to, url)
	end
	'It works!'
end

