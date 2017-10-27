class fsphys::homedir
(
	Hash $file_resources = {},
)
{
	$::userhomedirs.each |String $home| {
		$files = Hash($file_resources.map |String $title, Hash $parameters| {
			# overwrite path parameter if it exists
			if $parameters[path] {
				# titles must be unique!
				["fsphys::homedir-$home-$title",
					$parameters + {path => "$home/${parameters[path]}"}]
			}
			# otherwise, the path is in the title and must be modified there
			else {
				["$home/$title", $parameters]
			}
		})
		create_resources(file, $files)
	}
}

