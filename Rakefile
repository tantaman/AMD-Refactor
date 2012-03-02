require 'rake'

BASE_DIR = "./test"

task :refactor, :source, :destination do |t, args|
	source = args[:source]
	destination = args[:destination]

	if !destination
		puts "usage: rake refactor[source,destination]"
		exit
	end

	FileList["#{BASE_DIR}/**/*.js"].each do |fname|
		#puts fname
		pipe = IO.popen("amdRefactor #{source} < #{fname}")
		result = pipe.readlines
		pipe.close

		if result.length > 0
			# line col_start col_end
			importLoc = result[0].split(",")
			line = Integer(importLoc[0]) - 1
			colStart = Integer(importLoc[1]) - 1
			colEnd = Integer(importLoc[2])

			lines = File.readlines(fname);
			theLine = lines[line]
			theLine = 
				"#{theLine[0..colStart]}#{destination}#{theLine[colEnd..theLine.length]}"

			lines[line] = theLine

			puts "Refactoring: #{fname}"
			File.open(fname, 'w') { |f| f << lines }
			#puts lines
		end
	end
end

task :showDeps, :package do |t, args|
	myPkg = args[:package]

	if !myPkg
		puts "usage: rake showDeps[package]"
		exit
	end

	FileList["#{BASE_DIR}/#{myPkg}/**/*.js"].each do |fname|
		pipe = IO.popen("amdDeps #{myPkg} < #{fname}")
		result = pipe.readlines
		pipe.close

		if result.length > 0
			puts result
		end
	end
end