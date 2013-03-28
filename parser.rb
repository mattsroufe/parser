require 'nokogiri'
require 'open-uri'

@doc = Nokogiri::HTML(open("http://ecan.govt.nz/services/online-services/pages/authorised-solid-fuel-burners.aspx"))

def path(num)
  @doc.xpath("//span[@id='ctl00_PlaceHolderContentWrapper_PlaceHolderMain_editmodepanel2_UserControlFieldControl2_ctl00_lvBurner_ctrl#{num}_ApplianceName']")
end

woodburners = Array.new
i = 0
until path(i).empty?
	woodburners[i] = path(i).text
  i += 1
end
puts "#{woodburners.count} woodburners added to array."