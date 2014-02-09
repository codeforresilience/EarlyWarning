# vim: set noet sts=4 sw=4 ts=4 ft=ruby :

class Account
	include Mongoid::Document
	store_in collection: 'account'
	field :name, type: String
	field :phone_number, type: String
	field :loc, type: Hash
	index({'loc' => '2d'})

	def self.each_near(loc, meter)
		Account.within_circle(location: [loc, meter]) do |a|
			p loc
			p meter
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

