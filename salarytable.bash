#!/usr/bin/env bash

# bold text
bold=$(tput bold)
# normal text
norm=$(tput sgr0)

printf "%sPlease enter the relevant information\n" "${bold}"
line=-------------------------------------
printf "%s%s\n" "${line}" "${norm}"

format="%s%-25s%s"
q1=$(printf "${format}€" "${bold}" "current salary:" "${norm}")
q2=$(printf "${format}" "${bold}" "current scale point:" "${norm}")
q3=$(printf "${format}€" "${bold}" "increment value:" "${norm}")
q4=$(printf "${format}" "${bold}" "Are you a manager (y/n):" "${norm}")

read -rp "${q1}" salary
read -rp "${q2}" point
read -rp "${q3}" increment
read -rp "${q4}" manager

# for testing
# salary="0.5"
# point="0"
# increment="0.5"
# manager="y"

printf "\n%s%-8s | %5s | %17s |\n" "${bold}" "Date" "Point" "Salary / €"
line=-------------------------------------
printf "%s%s\n" "${line}" "${norm}"

new_point=${point}
current_year="$(date +%Y)"
current_month_text=$(date +%b)
current_month_numeric=$(date +%m)
# current_month_text=$(date +%b -d "now + 4 month")
# current_month_numeric=$(date +%m -d "now + 4 month")

printf "%3s %4d | %5d | %15.2f |\n" "${current_month_text}" "${current_year}" "${new_point}" "${salary}"
if [ "${current_month_numeric}" -lt 7 ] && [ "${manager}" == "y" ]; then
    new_point=$((new_point + 1))
    new_salary=$(echo "${salary} + (${new_point} - ${point}) * ${increment}" | bc)
    printf "%3s %4d | %5d | %15.2f |\n" "Jul" "${current_year}" "${new_point}" "${new_salary}"
fi
printf "%3s %4s | %5s | %15s |\n" " " " " " " " "

## two increments per year for a manager
if [ "${manager}" == "y" ]; then
    months=("Jan" "Jul")
else
    months=("Jan")
fi

months_length=${#months[@]}

for i in {1..4}; do
    current_year=$((current_year + 1))
    new_point=$((new_point + 1))
    for ((j = 0; j < months_length; j++)); do
        new_point=$((new_point + j))
        new_salary=$(echo "${salary} + (${new_point} - ${point}) * ${increment}" | bc)
        printf "%3s %4d | %5d | %15.2f |\n" "${months[${j}]}" "${current_year}" "${new_point}" "${new_salary}"
    done
    if [ "${manager}" = "y" ]; then
        printf "%3s %4s | %5s | %15s |\n" " " " " " " " "
    fi
done
