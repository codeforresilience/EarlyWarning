# vim: set noet sts=4 sw=4 ts=4 ft=ruby :
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

helpers do
	include Rack::Utils; alias_method :h, :escape_html
end

configure do
end

post '/voices/publish.xml' do
  <<-EOX
<?xml version="1.0" encoding="UTF-8"?>
<Response><Play>http://com.twilio.music.ambient.s3.amazonaws.com/aerosolspray_-_Living_Taciturn.mp3</Play><Play>http://com.twilio.music.ambient.s3.amazonaws.com/gurdonark_-_Plains.mp3</Play><Play>http://com.twilio.music.ambient.s3.amazonaws.com/gurdonark_-_Exurb.mp3</Play><Redirect></Redirect></Response>
  EOX
end

get '/voices/receipt.xml' do
	content_type 'text/xml'
	<<-EOX
<?xml version="1.0" encoding="UTF-8"?>
<Response>
<Say language="ja-JP" voice="alice">VOICE U R L の設定を変更することでこの文章を変更できます。</Say>
<Pause length="1"/>
<Say language="ja-JP" voice="alice">仕様のことでご不明点が御座いましたらご連絡ください。</Say>
</Response>
	EOX
end

post '/receipt' do
end



