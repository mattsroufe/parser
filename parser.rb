require 'nokogiri'
require 'open-uri'

@doc = Nokogiri::HTML(open("http://ecan.govt.nz/services/online-services/pages/authorised-solid-fuel-burners.aspx"))

def path(num, field)
  @doc.xpath("//span[@id='ctl00_PlaceHolderContentWrapper_PlaceHolderMain_editmodepanel2_UserControlFieldControl2_ctl00_lvBurner_ctrl#{num}_#{field}']")
end

manufacturers = Array.new
models = Array.new
i = 0
until path(i, "ApplianceName").empty?
	models[i] = path(i, "ApplianceName").text
	unless path(i, "ClientName").empty?
		manufacturers[i] = path(i, "ClientName").text
	end
  i += 1
end

puts "#{manufacturers.count} manufacturers added to array."
puts "#{models.count} woodburners added to array."

puts manufacturers.compact.index

manufacturers.each do |num|
  unless num == nil
  	puts "#{manufacturers.index(num)}: #{num}"
  end
end

#i = 0
#until path(i, "ApplianceName").empty?
#	if manufacturers[i]
#end