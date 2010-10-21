#!/bin/sh
#
#    q - unified search of the system
#
#    Copyright (C) 2010 Dustin Kirkland <kirkland@ubuntu.com>
#
#    Authors:
#        Dustin Kirkland <kirkland@ubuntu.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


get_commands() {
	echo "COMMANDS:"
	/usr/bin/python /usr/lib/command-not-found -- $1 2>&1 | grep Command | sed -e "s/^.*Command /\t/"
}

get_packages() {
	echo "PACKAGES:"
	apt-cache search $1 | sed -e "s/^/\t/"
}

get_documentation() {
	echo "DOCUMENTATION:"
	apropos $1 | sed -e "s/^/\t/"
}

get_files() {
	echo "FILES:"
	locate $1 2>&1 | sed -e "s/^/\t/"
}

search_all() {
	get_commands $1
	get_packages $1
	get_documentation $1
	get_files $1
}

search_all $1 | vim -c "set foldmethod=indent" -c "set foldminlines=0" -c "set foldnestmax=1"  -c "set foldcolumn=2" -R -
