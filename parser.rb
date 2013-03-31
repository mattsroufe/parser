require 'nokogiri'
require 'open-uri'

@doc = Nokogiri::HTML(open("http://ecan.govt.nz/services/online-services/pages/authorised-solid-fuel-burners.aspx"))

def path(num, field)
  @doc.xpath("//span[@id='ctl00_PlaceHolderContentWrapper_PlaceHolderMain_editmodepanel2_UserControlFieldControl2_ctl00_lvBurner_ctrl#{num}_#{field}']")
end

@manufacturers = Array.new
@models = Array.new
i = 0
until path(i, "ApplianceName").empty?
	@models[i] = path(i, "ApplianceName").text
	@manufacturers.push(i)
	unless path(i, "ClientName").empty?
		@manufacturers[i] = path(i, "ClientName").text
	end
  i += 1
end

puts "#{@manufacturers.count} manufacturers added to array."
puts "#{@models.count} woodburners added to array."
mod_manufacturers = @manufacturers.compact.uniq
puts "#{@manufacturers.count} manufacturers."
puts "#{@manufacturers.compact.count} non-nil manufacturers."
puts "#{mod_manufacturers.count} unique non-nil manufacturers."

def manufacturers_complete
	for i in 0...@manufacturers.count
		if @manufacturers[i].class == Fixnum
			@manufacturers[i] = @manufacturers[i - 1]
			# @manufacturers[i] = "Manufacturer_#{i}"
		end
		i += 1
	end
end

manufacturers_complete

# list models and index
def list_manufacturers
	@manufacturers.each do |manufacturer|
			puts "#{@manufacturers.index(manufacturer)}: #{manufacturer}"
	end
end

# list models and index
def list_models
	@models.each do |model|
		puts "#{@models.index(model)}: #{model}"
	end
end

# list manufacturers and models
def make_and_model
	for i in 0...@manufacturers.count
		puts "#{i}. #{@manufacturers[i]}: #{@models[i]}"
		i += 1
	end
end

make_and_model

__END__

a1 = ['apple', 1, 'banana', 2]
h1 = Hash[*a1.flatten]
puts "h1: #{h1.inspect}"

a2 = [['apple', 1], ['banana', 2]]
h2 = Hash[*a2.flatten]
puts "h2: #{h2.inspect}"

manufacturers.each do |manufacturer|
  unless manufacturer == nil
	  puts manufacturer
	  puts "======================================"
	  puts models[0..16]
	  #puts models[manufacturers.index(manufacturer)]
    

    #models.each do
	  #	while manufacturers.index(manufacturer).to_i < 17
	  #	if models.index(model) == manufacturers.index(manufacturer)
	  #	if models.index(model) < manufacturers.index(manufacturer)
		 # 	until manufacturer != nil
		 # 		puts models[manufacturers.index(manufacturer).to_i]
		  #	end
		  #end
	  #end
	  puts "\n"
  end
end