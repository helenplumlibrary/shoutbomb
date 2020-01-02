#!/bin/bash

# Set working directory to script directory
cd "$(dirname "$0")"

# Create a datestamp for today's day in YYYYMMDD format to be appended to output file names
date=$(date '+%Y%m%d')

# Replace the hostname and username below as appropriate for your institution.
# The password for is saved in the .pgpass password file. See readme.md for more information.
psql -h sierra-db.helenplum.org -p 1032 -d iii -U shoutbomb -t -A -f ./scripts/holds.sql -o ./holds/holds_$date.txt
psql -h sierra-db.helenplum.org -p 1032 -d iii -U shoutbomb -t -A -f ./scripts/overdues.sql -o ./overdues/overdues_$date.txt
psql -h sierra-db.helenplum.org -p 1032 -d iii -U shoutbomb -t -A -f ./scripts/renewals.sql -o ./renewals/renewals_$date.txt
psql -h sierra-db.helenplum.org -p 1032 -d iii -U shoutbomb -t -A -f ./scripts/text_patrons.sql -o ./text_patrons/text_patrons_$date.txt
psql -h sierra-db.helenplum.org -p 1032 -d iii -U shoutbomb -t -A -f ./scripts/voice_patrons.sql -o ./voice_patrons/voice_patrons_$date.txt


# This script uses an lftp bookmark names ShoutbombFTP with a saved username and password.
# See readme.md for more information.
lftp <<SCRIPT
set ssl:verify-certificate no
set ftps:initial-prot ""
set ftp:ssl-force true
set ftp:ssl-protect-data true
open ShoutbombFTP
mput -O Holds holds/*
mput -O Overdue overdues/*
mput -O Renew renewals/*
mput -O text_patrons text_patrons/*
mput -O voice_patrons voice_patrons/*
exit
SCRIPT

# Move uploaded files to the archive
mv holds/* archive/holds/
mv overdues/* archive/overdues/
mv renewals/* archive/renewals/
mv text_patrons/* archive/text_patrons/
mv voice_patrons/* archive/voice_patrons/

# Remove archived exports older than 14 days
find ./archive/ -type f -name '*.txt' -mtime +14 -exec rm {} \;