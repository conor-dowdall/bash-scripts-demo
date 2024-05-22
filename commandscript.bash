#!/usr/bin/env bash
# define a file name for the command outputs
file=out.txt

# clear the file contents
rm ${file}
touch ${file}

# bold text
bold=$(tput bold)
# normal text
norm=$(tput sgr0)

# nice spacing
format="%-22s%s\n"

printf "%sWriting the following output to %s\n" "${bold}" "${file}"
line=------------------------------------------------
printf "%s%s\n" "${line}" "${norm}"

get_date() {
  printf "${format}" "System Date:" "$(date)"
}

get_date
get_date >>${file}

get_hostname() {
  printf "${format}" "System Hostname:" "$(hostname)"
}

get_hostname
get_hostname >>${file}

get_arch() {
  printf "${format}" "System Architecture:" "$(arch)"
}

get_arch
get_arch >>${file}

get_uname() {
  printf "${format}" "System Info.:" "$(uname -a)"
}

get_uname
get_uname >>${file}

get_uptime() {
  printf "${format}" "System Uptime:" "$(uptime)"
}

get_uptime
get_uptime >>${file}

get_whoami() {
  printf "${format}" "Current User Name:" "$(whoami)"
}

get_whoami
get_whoami >>${file}

get_who() {
  printf "\nCurrent Users:\n%s\n" "$(who)"
}

get_who
get_who >>${file}

get_w() {
  printf "\nCurrent Users and Processes:\n%s\n" "$(w)"
}

get_w
get_w >>${file}

get_top() {
  printf "\nTop 5 Processes:\n%s\n" "$(top -b -n1 | grep '^ *[0-9]' | head -n5)"
}

get_top
get_top >>${file}
