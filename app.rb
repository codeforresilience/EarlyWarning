# vim: set noet sts=4 sw=4 ts=4 ft=ruby :
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

helpers do
	include Rack::Utils; alias_method :h, :escape_html
end

configure do
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



