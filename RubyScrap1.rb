require 'google_drive'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def send_it_to_drive(hash_list)
	session = GoogleDrive::Session.from_config("config.json")
	spreadsheet = session.spreadsheet_by_key("1s5iA6Z_MnrkjhvQQKVOE_s78ozxhzw3E-PuwkpIEpXg")
	worksheet = spreadsheet.worksheets.first
	hash_list.each do |row|
		worksheet.insert_rows(worksheet.num_rows + 1, [[row[:ville], row[:email]]])
	end
	worksheet.save
end

ab = ["http://www.annuaire-des-mairies.com/charente-maritime.html", "http://www.annuaire-des-mairies.com/charente-maritime-2.html", "http://www.annuaire-des-mairies.com/charente-maritime-3.html"]
ab.each do |cd|


def get_the_email_of_a_townhal_from_its_webpage(url, mairie)
	my_emails = []
	final_hash = []
	url.each do |page_url|
		doc = Nokogiri::HTML(open(page_url))
		a = doc.xpath('.//*[@class="Style22"]')
		my_emails << a[11].text[1..-1]
	end
	final_hash = mairie.zip(my_emails).map { |ville, email| {ville: ville, email: email} }
	send_it_to_drive(final_hash)
end


def get_all_the_urls_of_first_page(url)

	doc = Nokogiri::HTML(open(url))

	tabl = []
	mairie = []

	doc.xpath('.//*[@class="lientxt"]/@href').each do |node|
		tabl << "http://annuaire-des-mairies.com/#{node.text[1..-1]}"
	end

	doc.xpath('.//*[@class="lientxt"]').each do |node|
		mairie << node.text
	end
	get_the_email_of_a_townhal_from_its_webpage(tabl, mairie)
end

get_all_the_urls_of_first_page(cd)
end
