# vim: set noet sts=4 sw=4 ts=4 ft=ruby :

class Account
	include Mongoid::Document
	include Mongoid::Geospatial
	store_in collection: 'account'
	field :name, type: String
	field :phone_number, type: String
	geo_field :loc
	index({'loc' => '2d'})

	def self.each_near(loc, meter)
		p loc
		p meter
		# ToDo: use within and centerSphere
		# see also: http://tipshare.info/view/4f0d22494b21224c43000000
		Account.within_circle(location: [loc, meter]) do |a|
			p a
			yield a
		end
	end

	def call(client, from, to, url)
		client.account.calls.create(
			from: from,
			to:   to,
			url:  url,
		)
	end
end

