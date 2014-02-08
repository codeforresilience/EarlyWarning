# vim: set noet sts=4 sw=4 ts=4 ft=ruby :

class Account
	include Mongoid::Document
	store_in collection: 'account'
	field :name, type: String
	field :phone_number, type: String
	field :loc, type: Hash
	index({'loc' => '2d'})
end

