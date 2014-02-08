xml.instruct! :xml, :version => '1.0', :encoding='UTF-8'
xml.Reponse do
	xml.Play do
		xml.text! 'http://com.twilio.music.ambient.s3.amazonaws.com/aerosolspray_-_Living_Taciturn.mp3'
	end
	xml.Play do
		xml.text! 'http://com.twilio.music.ambient.s3.amazonaws.com/gurdonark_-_Plains.mp3'
	end
	xml.Play do
		xml.text! 'http://com.twilio.music.ambient.s3.amazonaws.com/gurdonark_-_Exurb.mp3'
	end
end

