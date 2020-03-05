#!/bin/bash

# assign variables
VERSION=1.0.1
ACTION=${1}


function show_version() {
echo "Provision version ${1}"
}


function start_webserver() {

# Update all system packages
sudo yum update -y

# Install the Nginx software package
sudo amazon-linux-extras install nginx1.12 -y

# Configure Nginx to automatically start at system boot up
sudo chkconfig nginx on

# Copy the website documents from s3 to the web document root directory
sudo aws s3 cp s3://rfookune-assignment-webserver/index.html /usr/share/nginx/html/index.html

# Start the Nginx service
sudo service nginx start

}


function remove_webserver() {

#Stop the Nginx service.
sudo service nginx stop

#Delete the files in the website document root directory
sudo rm /usr/share/nginx/html/index.html

#Uninstall the Nginx software package
sudo yum remove nginx -y

}


function display_help() {

cat << EOF

Start Nginx webserver
Usage: ${0} {-r|--remove|-v|--version|-h|--help}
OPTIONS:
	-r | --remove  Remove Nginx webserver
	-v | --version Display the command version
	-h | --help    Display the command help
Examples:
	Start Nginx webserver:
		$ ${0}
	Remove Nginx webserver:
                $ ${0} -r
	Display version:
                $ ${0} -v
	Display help:
		$ ${0} -h
EOF

}



case "$ACTION" in
	-v|--version)
		show_version $VERSION
		;;
	-h|--help)
		display_help
		;;
	-r|--remove)
                 remove_webserver
                ;;
	*)
	start_webserver
	exit 1
esac
