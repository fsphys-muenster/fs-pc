# This class is used to set both the message of the day (“MOTD”) displayed
# on the command line as well as the GUI message displayed on the login screen.
# Currently, the GUI message ist only set for GDM.
# The following modules are used for the different kinds of MOTD:
# - CLI: puppetlabs/motd
# - GDM: camptocamp/gnome
class fsphys::motd
(
	Numeric $cli_line_length = 80,
	Boolean $dynamic_motd = true,
	String  $motd         = '',
)
{
	### CLI
	# Word-wrap message and append newline for console output
	$motd_cli = word_wrap("$motd\n", $cli_line_length)
	class { motd:
		content      => $motd_cli,
		dynamic_motd => $dynamic_motd,
	}

	### GUI
	## GDM
	# See also
	# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/desktop_migration_and_administration_guide/customizing-login-screen

	# String values must be in single quotes and newlines written as “\n” for
	# the gnome::gsettings type
	$motd_gsettings = regsubst("'$motd'", "\n", '\n', 'G')
	gnome::gsettings { fsphys-motd-gdm-enable:
		schema => 'org.gnome.login-screen',
		key    => banner-message-enable,
		value  => $motd != '',
	}
	gnome::gsettings { fsphys-motd-gdm-text:
		schema => 'org.gnome.login-screen',
		key    => banner-message-text,
		value  => $motd_gsettings,
	}
}

