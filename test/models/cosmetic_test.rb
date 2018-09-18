require 'watir'
require 'webdrivers'
require 'roo'
require 'csv'

username = "mansoorelahi"
password = "2watAX2eiImC"

browser = Watir::Browser.new :firefox
browser.goto "https://www.cosmeticanalysis.com/login.html"

browser.text_field(:id => "login").set username
browser.text_field(:id => "password").set password
browser.button(:id => "loginButton").click

@characteristics = []
@urls = []
@names = []

spreadsheet               = Roo::Excelx.new("#{Rails.root}/data/Cosmetic Analysis INgredient links.xlsx")
spreadsheet.default_sheet = 'Sheet1'
header                    = spreadsheet.row(1)
(2..spreadsheet.last_row).each do |i|
	puts "#{i}"
	row = Hash[[header, spreadsheet.row(i)].transpose]
	name = row["Ingredient"]
	url = row ["Ingredient_link-href"]
	browser.goto "#{url}"

	single_characteristics = []
	if browser.ul(class: 'ingredientAssets').present?
		browser.ul(class: 'ingredientAssets').lis.each do |li|
			char ={}
			char["Rating"] = li.span(class: "rating").image.title.split(": ").last
			char["value"] = li.span(class: "label").text
			single_characteristics << char
		end
	else
		single_characteristics << nil
	end
	@characteristics.push(single_characteristics)
	@urls.push(url)
	@names.push(name)
end
browser.close

def get_results
	results = []
	(0...@characteristics.length).each do |i|
		results << [@names[i], @urls[i], @characteristics[i]]
	end
	results
end


@results = get_results
require 'csv'
CSV.open("/home/progton/Documents/cosmetic.csv", "wb") do |csv|
  csv << ["name", "url", "characteristics"]# adds the attributes name on the first line
  @results.each do |result|
    csv << result
  end
end