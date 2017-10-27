# exports the custom fact “userhomedirs” which is a String array containing all
# subdirectories of /home/ (as absolute paths, without trailing slashes)
homedirs = Dir.glob('/home/*').select {|f| File.directory? f}

Facter.add('userhomedirs'.intern) do
	setcode { homedirs }
end

