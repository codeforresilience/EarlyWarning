setup:
	bundle install
	git submodule init
	git submodule update

run:
	bundle exec rackup
