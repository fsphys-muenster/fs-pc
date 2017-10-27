class fsphys::homedir
(
	Hash $file_resources = {},
	Hash $tidy_resources = {},
)
{
	$resources = {
		file => $file_resources,
		tidy => $tidy_resources,
	}
	$resources.each |String $type, Hash $values| {
		$::userhomedirs.each |String $home| {
			$home_resources = Hash($values.map |String $title, Hash $parameters| {
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
			create_resources($type, $home_resources)
		}
	}
}

