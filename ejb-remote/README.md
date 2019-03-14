# Build example

This example requires that the apacheds is running and properly configured (follow the guide in this repo).

## Build Server

> cd server-side 

> mvn clean install -Dcheckstyle.skip

## Build Client

> cd client

> mvn clean package

# Setup EAP

## Configure the server

Create the new keytab

> java -classpath target/kerberos-using-apacheds.jar org.jboss.test.kerberos.CreateKeytab remote/localhost@JBOSS.ORG remotepwd remote.keytab

Copy the `remote.keytab` to the $EAP_HOME/standalone path

Run the script to apply the configuration:

> script-name

## Install ejb in EAP

> cp server-side/target/ejb-remote-server-side.jar $EAP_HOME/standalone/deployments

Check the log for success deploy

# Setup the client

Setup env variable `KRB5_CONFIG` to point a valid krb5 file:

> KRB5_CONFIG=$PATH_TO/krb5.conf

You need to login with kerberos:

> mkdir $PATH_TO/cc-cache/

> kinit -c $PATH_TO/cc-cache/krbtest tstark@JBOSS.ORG

This will login the user tstartk

Setup environment variable `KRB5CCNAME` so the runtime can access to the ticket cache we created:
> KRB5CCNAME=$PATH_TO/cc-cache/krbtest

## Run the client

> mvn exec:exec
