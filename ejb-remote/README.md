# Setup EAP

Run the script to apply the configuration:

	$EAP72_HOME/bin/standalone.sh
	$EAP72_HOME/bin/jboss-cli.sh -c --file=jboss-cli-command.cli


# Build example

This example requires that the apacheds is running and properly configured (follow the guide in this repo).

## Build Server

> cd server-side

> mvn clean install -Dcheckstyle.skip

### Install ejb in EAP

> cp target/ejb-remote-server-side.jar $EAP72_HOME/standalone/deployments

## Build Client

> cd client

> mvn clean package



Check the log for success deploy

# Setup the client

Setup env variable `KRB5_CONFIG` to point a valid krb5 file:

> export KRB5_CONFIG=$PATH_TO/krb5.conf

You need to login with kerberos:

    mkdir /tmp/cc_cache
    kinit -c /tmp/cc_cache/krbtest tstark@JBOSS.ORG
    klist --cache=/tmp/cc_cache/krbtest


This will login the user tstartk

Setup environment variable `KRB5CCNAME` so the runtime can access to the ticket cache we created:
> export KRB5CCNAME=/tmp/cc_cache/krbtest

## Run the client

The client needs the krb5.conf, so copy the krb5.conf into `/etc/` dir
	sudo cp /etc/krb5.conf /etc/krb5.conf_ORIGINAL
	sudo cp krb5.conf /etc/

> mvn exec:exec
