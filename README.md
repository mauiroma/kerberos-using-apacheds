# Kerberos server demo - using ApacheDS

A sample Kerberos project using ApacheDS directory service.

## How to get the sources

You should have [git](http://git-scm.com/) installed

	$ git clone git://github.com/mauiroma/kerberos-using-apacheds.git

Forked from:

	$ git clone git://github.com/kwart/kerberos-using-apacheds.git


## Build the project

You need to have [Maven](http://maven.apache.org/) installed

	$ cd kerberos-using-apacheds
	$ mvn clean package

## Run the Kerberos server

Launch the generated JAR file. You can put LDIF files as the program arguments:

	$ java -jar target/kerberos-using-apacheds.jar test.ldif

You can use property  `${hostname}` in the LDIF file and it will be replaced by the canonical server host name:

	dn: uid=HTTP,ou=Users,dc=jboss,dc=org
	objectClass: top
	objectClass: person
	objectClass: inetOrgPerson
	objectClass: krb5principal
	objectClass: krb5kdcentry
	cn: HTTP
	sn: Service
	uid: HTTP
	userPassword: httppwd
	krb5PrincipalName: HTTP/${hostname}@JBOSS.ORG
	krb5KeyVersionNumber: 0

### Bind address

The server binds to `localhost` by default. If you want to change it, set the Java system property `kerberos.bind.address`:

	$ java -Dkerberos.bind.address=192.168.0.1 -jar target/kerberos-using-apacheds.jar test.ldif

### krb5.conf

The application generates simple `krb5.conf` file when launched in the current directory. If you want to use another file,
specify the `kerberos.conf.path` system property:

	$ java -Dkerberos.conf.path=./krb5.conf -jar target/kerberos-using-apacheds.jar test.ldif

### Test the access - user login

Either configure the JBOSS.ORG realm in the `/etc/krb5.conf` or define alternative path using `KRB5_CONFIG` system variable

	$ export KRB5_CONFIG=/tmp/krb5.conf

Authenticate as a sample user from your LDIF file (`test.ldif`)

	$ kinit tstark@JBOSS.ORG
	Password for tstark@JBOSS.ORG: password

Verify issued token:

	$ klist

Remove issued token:

	$ kdestroy


## Stop running server

Use `stop` command line argument:

	$ java -jar target/kerberos-using-apacheds.jar stop

# Testing into EAP 7.2

## Generate keytab

The project contains a simple Kerberos keytab generator:

	$ java -classpath kerberos-using-apacheds.jar org.jboss.test.kerberos.CreateKeytab
	Kerberos keytab generator
	-------------------------
	Usage:
	java -classpath target/kerberos-using-apacheds.jar org.jboss.test.kerberos.CreateKeytab <principalName> <passPhrase> [<principalName2> <passPhrase2> ...] <outputKeytabFile>

	$ java -classpath target/kerberos-using-apacheds.jar org.jboss.test.kerberos.CreateKeytab HTTP/localhost@JBOSS.ORG httppwd http.keytab
	Keytab file was created: $PWD/http.keytab

	$ ktutil -k http.keytab list

## Configure EAP V 7.2

	cd demo-app
	cp ../krb5.conf ../http.keytab $EAP72_HOME/
	$EAP72_HOME/bin/standalone.sh
	$EAP72_HOME/bin/jboss-cli.sh -c --file=jboss-cli-command.xml
	mvn cleap package
	mv target/spnego-demo.war $EAP72_HOME/deployment
	sh ./run-browser.sh

if you used `tstark` user when you ran `kinit` command you be able to view `marvel` page but not dccomics page

if you used `bwayne` user when you ran `kinit` command you be able to view `dccomics` page but not marvel page

if you missed to authenticate with kerberos, the security method allow fallback with basic where the browser prompt in order to insert credentials