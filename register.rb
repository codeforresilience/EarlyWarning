#!/usr/bin/env ruby

require 'yaml'

def main
	print "Input your Name: "
	name = $stdin.readline.chomp
	print "Input your Phone Number: "
	phone_number = $stdin.readline.chomp
	print "Input your location(lat, lon): "
	line = $stdin.readline.chomp
	line =~ %r!([0-9\.]+),\s+([0-9\.]+)!
	lat, lon = $1.to_f, $2.to_f
	data = {
		name: name,
		phone_number: phone_number,
		loc: {
			lat: lat,
			lon: lon
		},
	}
	puts data.to_yaml
end

if $0 == __FILE__ then
	main
end


