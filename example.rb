#!/usr/bin/env ruby

require 'rubygems'
require 'pit'
require 'twilio'

config = Pit.get("twilio",
                 :require => {
  'sid' => 'twilio sid',
  'token' => 'twilio auth token',
})




