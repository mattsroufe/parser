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

def make_and_model_2
	for i in 0...@manufacturers.count
		if @manufacturers[i - 1] == @manufacturers[i]
			puts @models[i]
		else
			puts "\n#{@manufacturers[i]}"
			puts "======================================"
			puts @models[i]
		end
		i += 1
	end
end

@h = Hash.new
def arrays_to_hash
	for i in 0...@manufacturers.count
		if @manufacturers[i - 1] == @manufacturers[i]
			@h[@manufacturers[i]] << @models[i]
		else
			@h[@manufacturers[i]] = []
			@h[@manufacturers[i]] << @models[i]
		end
		i += 1		
	end
end

def list_hash
	# puts h.keys.inspect
	# puts h.values.inspect
	@h.each do |k, v| 
		puts "\n#{k}"
		puts "======================================"
		# puts "#{v}\n"
		v.each do |model|
			puts model
		end
	end
end

arrays_to_hash
# list_hash
puts @h

__END__

class Article
  attr_accessor :name, :month

  def initialize(name, month)
    @name = name
    @month = month
  end
end

articles = [
  Article.new("Article1", "Feb"), 
  Article.new("Article2", "Feb"), 
  Article.new("Article3", "Feb"), 
  Article.new("Article4", "Mar"), 
  Article.new("Article5", "Mar"), 
]

months = {}
articles.each do |a|
  months[a.month] ||= []
  months[a.month] << a.name
end

p months