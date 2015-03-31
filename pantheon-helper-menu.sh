#!/bin/bash
# Pantheon Helper Bash Script
# 
#  Author: Sam Roy
#  Company: MakinItMagazine
#  Web Site: www.makinitmag.com
#  Email: sroy@makinitmag.net
#  NOTES: Git commands simplified.
###

function pause(){
   read -p "$*"
}
###########
# any option can be set to default to "on"
cmd=(dialog --separate-output --checklist "Pantheon Helper - options:" 22 76 16)
options=(
				 1 "Clone DEV into ~/public_html" off    
         2 "Git - log" off
				 3 "STATUS" off
				 4 "Git - add" off
         5 "Git - commit" off
				 6 "Git - push to MIM DEV" off
				 7 "Git - pull" off
				 8 "Sync database and files" off
         9 "Clean up and exit" off
				 )
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
##############################################################################
# CASES
##############################################################################
for choice in $choices
do
    case $choice in
        1)
            echo "*** Cloning MIM dev into public_html"
            echo "*******************************************"
git clone ssh://codeserver.dev.13cd6f18-64ba-40c2-8d33-7c5ec8e06af5@codeserver.dev.13cd6f18-64ba-40c2-8d33-7c5ec8e06af5.drush.in:2222/~/repository.git mim;
mv mim/ public_html/;
./menu.sh;
            ;;
        2)
            echo "*** Generating current status"
            echo "*******************************************"
						rm ~/status.txt;
						touch ~/status.txt;
						echo "*******************************************" >> ~/status.txt;
						echo "***********  WORKING DIRECTORY SIZE *******" >> ~/status.txt;
						du -hs ~/public_html >> ./status.txt;
						echo "*******************************************" >> ~/status.txt;
						echo "***********  Git STATUS *******************" >> ~/status.txt;
						cd ~/public_html; git status >> ~/status.txt; cd;
						date >> ~/status.txt;
						less  ~/status.txt;
						echo "*** Generating current status";
            echo "*******************************************";
						./menu.sh;
            ;;
			  3)
						echo "Last checked" >> ~/status.txt;
						date >> ~/status.txt;
						less ~/status.txt;
						echo "*** Done" | more;
						./menu.sh;
            ;;
				4)
            echo "*** ADDing current changes to local repository"
            echo "**************************************************"
						cd ~/public_html; git add --all; cd;
						echo "*** Done" | more;
						./menu.sh;
            ;;							
        5)
            echo "*** COMMIT to MIM DEV"
            echo "**************************************************"
						cd ~/public_html; git commit; cd;
						echo "*** Done" | more;
						./menu.sh;				
            ;;
        6)
						echo "*** PUSHing current commit to MIM dev at Pantheon."
            echo "**************************************************"
						cd ~/public_html; git push >> ~/status.txt; cd;
						echo "*** Done" | more;
            ./menu.sh;
						;;
				7)
					dialog --title "Display tree view?"  --yesno "Are you sure?" 6 25						
					tree -A -h --du --charset=ASCII ~/public_html/sites/ | more
					./menu.sh;
					;;
7)
					dialog --title "Start importing database from LIVE? (this will overwrite current local DB)"  --yesno "Are you sure?" 6 25						
					drush -d sql-sync-pipe @pantheon.mim.live @self
					./menu.sh;
					;;								
				9)
				dialog --title "Message"  --yesno "Are you sure?" 6 25
        echo "*** CLEAN UP";
				rm -Rf ~/public_html; 
        echo "*** Displaying current directory";
				ls ~/;
				;;														
    esac
done
