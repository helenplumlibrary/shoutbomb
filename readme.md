

Create a .pgpass password file containing your Sierra database server information, including credentials for an account with SQL access
Format: hostname:port:database:username:password
Example: sierra-db.helenplum.org:1032:iii:shoutbomb:PASSWORD

[LINK TO CSDIRECT DOCUMENTATION]


On Unix systems, the permissions on .pgpass must disallow any access to world or group; achieve this by the command chmod 0600 ~/.pgpass. If the permissions are less strict than this, the file will be ignored. On Microsoft Windows, it is assumed that the file is stored in a directory that is secure, so no special permissions check is made.
See the PostgreSQL documentation for more information: https://www.postgresql.org/docs/9.6/libpq-pgpass.html


Create an lftp bookmark names ShoutbombFTP containing your FPT credentials ftp.shoutbomb.com:
lftp -c "bookmark add ShoutbombFTP ftps://USERNAME:PASSWORD@ftp.shoutbomb.com"


