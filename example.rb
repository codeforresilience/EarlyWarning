#!/usr/bin/env ruby

require 'rubygems'
require 'pit'
require 'twilio-ruby'

def call(config)
  client = Twilio::REST::Client.new(config['sid'], config['token'])

  from = config['from']
  to = config['to']
  client.account.calls.create(
    from: from,
    to:   to,
    url:  'http://ewsb.no32.tk/voices/publish.xml',
    # url:  'http://ewsb.no32.tk/voices/receipt.xml',
  )
end

if $0 == __FILE__ then
  config = Pit.get('twilio',
                   :require => {
    'sid'   => 'twilio sid',
    'token' => 'twilio auth token',
    'from' => 'twilio from phone number',
    'to' => 'target phone number'
  })
  call(config)
end


