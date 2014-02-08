xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'
xml.Response do
	xml.Say 'language' => 'ja-JP', 'voice' => 'alice' do
		xml.text! 'TwiML の設定を変更することで、発話内容を変更できます。'
	end
	xml.Pause 'length' => '1'
end
