default["ircd"]["name"] = node["fqdn"]
default["ircd"]["ip"] = node["ipaddress"]
default["ircd"]["description"] = "Example server"
default["ircd"]["network_name"] = "Example network"
default["ircd"]["network_description"] = "Example network description"
default["ircd"]["port"] = "6667"
default["ircd"]["motd"] = "Nothing to see here, move along"
default["ircd"]["admin"]["name"] = "Example admin"
default["ircd"]["admin"]["email"] = "admin@example.com"

default["ircd"]["service"] = "ircd"
default["ircd"]["package"] = "ircd-ratbox"
default["ircd"]["config_path"] = "/etc/ircd"
default["ircd"]["log_path"] = "/var/log/ircd"
default["ircd"]["share_path"] = "/usr/share/ircd"
default["ircd"]["services_config_path"] = "/etc/ratbox-services"
default["ircd"]["service_password"] = "$1$uoIXxCX6$..iXN0jLHHLq6h/RYEG/Y/"

# For the below config variables all attributes are required!
default["ircd"]["auth"]["classes"] = {
	"users" => {
		"ping_time" => "2 minutes",
		"number_per_ident" => "2",
		"number_per_ip" => "3",
		"number_per_ip_global" => "5",
		"cidr_ipv4_bitlen" => "24",
		"cidr_ipv6_bitlen" => "64",
		"number_per_cidr" => "4",
		"max_number" => "100",
		"sendq" => "100 kbytes"
	},
	"restricted" => {
		"ping_time" => "1 minute 30 seconds",
		"number_per_ip" => "1",
		"max_number" => "100",
		"sendq" => "60kb"
	},
	"opers" => {
		"ping_time" => "5 minutes",
		"number_per_ip" => "10",
		"max_number" => "100",
		"sendq" => "100kbytes"
	},
	"server" => {
		"ping_time" => "5 minutes",
		"connectfreq" => "5 minutes",
		"max_number" => "1",
		"sendq" => "2 megabytes"
	}
}

default["ircd"]["auth"]["class_mapping"] = [ {
	"user" => "*@*",
	"class" => "users"
} ]