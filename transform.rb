require 'json'


File.open("conf.json", "r") do |file|
	@array = JSON.parse(file.read)
	@coefs = {}
	@array.each do |key,arr|
		temp_countet = 0
		
		arr.each do |key2,inarr|
			temp_countet+=inarr
		end

		@coefs[key] = 100.0/temp_countet
		
		arr.each do |key2,elm|
			@array[key][key2] = (@coefs[key]*elm).to_i.to_s+"%"
		end

	end
end

File.open("transformed.json", "w") do |file|
	file.print(JSON.generate(@array))
end
p @array