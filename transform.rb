require 'json'


File.open("conf.json", "r") do |file|
	@array = JSON.parse(file.read)
	@coefs = {}
	@array.each do |key,arr|
		temp_countet = 0
		
		arr.each do |key2, inarr|
			temp_countet+=inarr
		end

		@coefs[key] = 100.0/temp_countet.to_f
		
		arr.each do |key2,elm|
			@array[key][key2] = (@coefs[key]*elm)
		end

	end
end


###part prepearing array for google chart 

@array = @array.flatten
@array = @array.map do |a|
	if a.class == String
		next
	else
		 a.to_a
	end
end.compact

@out = {}
n = 0
@array.each do |core|
	core.each do |currentFreq, precent|
		@out[currentFreq] = [] if not @out[currentFreq]
		@out[currentFreq][n] = precent
	end
	n+=1
end

@out = @out.map do |elm| 
	elm.to_a.flatten!
	4.times do |i|
		i+=1
		if not elm[i] 
			elm[i] = 0
		end
	end
	elm
end

def nummered str, n
	out = []
	n.times do |i|
		out << str.sub(/%./, i.to_s)
	end
	out
end
@out.sort!
header = [["fr"] + (nummered "cpu %s", n)]

@out = header + @out

#saving
File.open('template.html', 'r') do |file|
	newFile = file
				.read()
				.sub(/%list%/, JSON.generate(@out))
	File.open('out.html', 'w') do |file|
		file.print(newFile)
	end

end

