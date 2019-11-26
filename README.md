# Helen Plub Library Shoutbomb Scripts
This bash script can be used to extract data from the Sierra ILS PostgreSQL database and transfer it to Shoutbomb for phone notifications.

The script handles holds, overdues, renewals, and patron notice preference (SMS text or voice call). The notice type is determined based on the value of the patron's PCODE1 field in Sierra, but `text_patrons.sql` and `voice_patrons.sql` could be modified to look at different fields.
  
## Requirements
The script depends on [psql](https://www.postgresql.org/docs/current/app-psql.html) to query PostgreSQL and [lftp](http://lftp.tech/) for FTPS transfers.

You will also need a Sierra account with [SQL privileges](https://csdirect.iii.com/sierrahelp/Default.php#ssql/ssql_getting_started.html). 
  
## Setup
1. Create a [.pgpass](http://www.postgresql.org/docs/current/static/libpq-pgpass.html) password file containing your Sierra database server information and credentials. Example:
`sierra-db.helenplum.org:1032:iii:shoutbomb:PASSWORD`
  
1. Create an lftp bookmark names ShoutbombFTP containing your FPT credentials ftp.shoutbomb.com:
`lftp -c "bookmark add ShoutbombFTP ftps://USERNAME:PASSWORD@ftp.shoutbomb.com"`

1. Schedule a cron job to run `shoutbomb.sh` at least once per day.