# Collection of Notes to my future self

## Multiple Git Account Management

1. update `./update_gitconfig.sh`
1. Copy `./update_gitconfig.sh` to `~/`
1. run `bash ~/update_gitconfig.sh` to switch
1. run `git whoami` when you forget

## ODBC

#### Getting Started with ODBC on Mac for pyodbc

1. Brewscript installs `unixodbc`
1. Run `odbcinst -j` to show current config
1. `odbc.ini` is where the magic happens make sure its in `~/`
1. `odbc.ini` is different for each database `./odbc.ini` is a postgres sample

## [Kerberos](https://web.mit.edu/kerberos/krb5-latest/doc/basic/ccache_def.html) Nonsense

#### Creating a key tab file
`ktutil -k name.keytab add -p {user}@{host} -e aes256-cts-hmac-sha1-96 -V 4`
#### Authenticating with it
`kinit -k -t {path}/name.keytab`  
`klist` to check and see how it went

#### Mac Specific
`export KRB5CCNAME=/etc/krb5.conf;`  
sample in `./Kerberos/krb5.conf`

#### Windows Specific
`KRB5CCNAME=C:\Users\{user}\misc\KerberosTickets.conf`  
`KRB5_CONFIG=C:\Windows\krb5-ini-pre-kfw4.conf`  
Can't remember if `./windows_kerberos/jaas.conf` is needed in `C:\Windows\`
