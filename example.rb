#!/usr/bin/env ruby

require 'rubygems'
require 'pit'
require 'twilio-ruby'

def call(config)
  client = Twilio::REST::Client.new(config['sid'], config['token'])

  from = config['from_phone_number']
  client.account.calls.create(
    from: from,
    to:   '+81XXXXXXXXXX',
    url:  'http://xxx.heroku.com/callback',
  )
end

if $0 == __FILE__ then
  config = Pit.get('twilio',
                   :require => {
    'sid'   => 'twilio sid',
    'token' => 'twilio auth token',
  })
  config['from_phone_number'] = '+815031318881'
  call(config)
end


