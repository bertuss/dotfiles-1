#!/usr/bin/env bash

SCRIPTS_DIR=$(dirname "$(python3 -c "import os; print(os.path.realpath('$0'))")")

# shellcheck source=_build.sh
. "${SCRIPTS_DIR}/_common.sh" "$@"

bytesToHuman() {
	b=${1:-0}
	d=''
	s=0
	S=(Bytes {K,M,G,T,E,P,Y,Z}iB)
	while ((b > 1024)); do
		d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
		b=$((b / 1024))
		let s++
	done
	echo "$b$d ${S[$s]} of space was cleaned up :3"
}

main() {
	oldAvailable=$(df / | tail -1 | awk '{print $4}')

	echo 'Empty the Trash on all mounted volumes and the main HDD...'
	sudo rm -rfv /Volumes/*/.Trashes &>/dev/null
	sudo rm -rfv ~/.Trash &>/dev/null

	echo 'Clear System Log Files...'
	sudo rm -rfv /private/var/log/asl/*.asl &>/dev/null
	sudo rm -rfv /Library/Logs/DiagnosticReports/* &>/dev/null
	sudo rm -rfv /Library/Logs/Adobe/* &>/dev/null
	rm -rfv ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/* &>/dev/null
	rm -rfv ~/Library/Logs/CoreSimulator/* &>/dev/null

	echo 'Clear Adobe Cache Files...'
	sudo rm -rfv ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/* &>/dev/null

	echo 'Cleanup iOS Applications...'
	rm -rfv ~/Music/iTunes/iTunes\ Media/Mobile\ Applications/* &>/dev/null

	echo 'Remove iOS Device Backups...'
	rm -rfv ~/Library/Application\ Support/MobileSync/Backup/* &>/dev/null

	echo 'Cleanup XCode Derived Data and Archives...'
	rm -rfv ~/Library/Developer/Xcode/DerivedData/* &>/dev/null
	rm -rfv ~/Library/Developer/Xcode/Archives/* &>/dev/null

	echo 'Cleanup Homebrew Cache...'
	brew cleanup --force -s &>/dev/null
	brew cask cleanup &>/dev/null
	rm -rfv /Library/Caches/Homebrew/* &>/dev/null
	brew tap --repair &>/dev/null

	echo 'Cleanup any old versions of gems'
	gem cleanup &>/dev/null

	echo 'Cleanup Docker...'
	docker rmi $(docker images | grep "<none>" | awk '{print $3}') 2>/dev/null || echo "No untagged images to delete."
	docker rm -vf $(docker ps -a | grep "Exited" | awk '{print $1}') 2>/dev/null || echo "No stopped containers to remove."

	echo 'Purge inactive memory...'
	sudo purge

	clear && echo 'Success!'

	newAvailable=$(df / | tail -1 | awk '{print $4}')
	count=$((newAvailable - oldAvailable))
	count=$(($count * 512))
	bytesToHuman $count
}

assert_mac
confirm
main
