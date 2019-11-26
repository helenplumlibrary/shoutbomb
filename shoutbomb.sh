#!/bin/bash

# Create a datestamp for today's day in YYYYMMDD format to be appended to output file names
date=$(date '+%Y%m%d')

# Replace the hostname and username below as appropriate for your institution.
# The password for is saved in the .pgpass password file. See readme.md for more information.
psql -h sierra-db.helenplum.org -p 1032 -d iii -U shoutbomb -f shoutbomb_text.sql -o shoutbomb_text_$date.txt
psql -h sierra-db.helenplum.org -p 1032 -d iii -U shoutbomb -f shoutbomb_voice.sql -o shoutbomb_voice_$date.txt


# This script uses an lftp bookmark names ShoutbombFTP with a saved username and password.
# See readme.md for more information.
lftp <<SCRIPT
set ssl:verify-certificate no
set ftps:initial-prot ""
set ftp:ssl-force true
set ftp:ssl-protect-data true
open ShoutbombFTP
put -O text_patrons shoutbomb_text_$date.txt
put -O voice_patrons shoutbomb_voice_$date.txt
exit
SCRIPT

# Optionally, uncomment the following lines to delete the exported user data after upload.
#rm shoutbomb_text_$date.txt
#rm shoutbomb_voice_$date.txt
