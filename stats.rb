require 'json'

while true
	sleep 0.5
	out = IO.popen("cat /proc/cpuinfo | grep -i mhz")
	out = out.read()
	if(out.length == 1) then 
		puts "somethings went wrong..."
		exit
	end

	cpu_s_frq = {}

	out = out.split("\n")
	
	out.size.times do |n|
		cpu_s_frq["cpu n#{n}"] = out[n].scan(/\d+.\d+/)[0]
	end

	file_str = ""
	stats = {}
	if(File.exist?("conf.json")) then
		File.open("conf.json", "r") do |file|  
			file_str = file.read()
			if(file_str.size > 0) then
				stats = JSON.parse(file_str)
			end
		end	
	end

	File.open("conf.json", "w+") do |file|  
		cpu_s_frq.each do |cpu_n,frequency|
			if(not stats[cpu_n]) then 
				stats[cpu_n] = {}
			end

			if(not stats[cpu_n][frequency]) then
				stats[cpu_n][frequency] = 1
			else
				stats[cpu_n][frequency] +=1
			end

			stats[cpu_n] = stats[cpu_n].sort_by {|_key, value| value}.to_h
		end

		file.print(JSON.generate(stats))
	end
end