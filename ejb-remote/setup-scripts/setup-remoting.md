
/core-service=management/security-realm=krbRealm:add()

/core-service=management/security-realm=krbRealm/server-identity=kerberos:add()

/core-service=management/security-realm=krbRealm/server-identity=kerberos/keytab=HTTP\/localhost@JBOSS.ORG:add(path=http.keytab, relative-to=jboss.server.base.dir, debug=true)

/core-service=management/security-realm=krbRealm/authentication=kerberos:add(remove-realm=true)

reload

/subsystem=security/security-domain=krb-remoting-domain:add()

/subsystem=security/security-domain=krb-remoting-domain/authentication=classic:add()

/subsystem=security/security-domain=krb-remoting-domain/authentication=classic/login-module=Remoting:add(code=Remoting, flag=optional, module-options=[password-stacking=useFirstPass])

/subsystem=security/security-domain=krb-remoting-domain/authentication=classic/login-module=RealmDirect:add(code=RealmDirect, flag=required, module-options=[password-stacking=useFirstPass, realm=krbRealm])

/subsystem=security/security-domain=krb-remoting-domain/mapping=classic:add()

/subsystem=security/security-domain=krb-remoting-domain/mapping=classic/mapping-module=SimpleRoles:add(code=SimpleRoles, type=role, module-options=["testUser"="testRole"])

reload


/subsystem=remoting/http-connector=http-remoting-connector:write-attribute(name=security-realm, value=krbRealm)



 <security-domain name="krb-remoting-domain">
                    <authentication>
                        <login-module code="Remoting" flag="optional">
                            <module-option name="password-stacking" value="useFirstPass"/>
                        </login-module>
                        <login-module code="RealmDirect" flag="required">
                            <module-option name="password-stacking" value="useFirstPass"/>
                            <module-option name="realm" value="krbRealm"/>
                        </login-module>
                    </authentication>
                    <mapping>
                        <mapping-module code="SimpleRoles" type="role">
                            <module-option name="testUser" value="testRole"/>
                        </mapping-module>
                    </mapping>
                </security-domain>



                <security-domain name="ejb-kerberos" cache-type="default">
					<authentication>
						<login-module code="Remoting" flag="optional">
							<module-option name="password-stacking" value="useFirstPass" />
						</login-module>
						<login-module code="RealmUsersRoles" flag="required">
							<module-option name="password-stacking" value="useFirstPass" />
							<module-option name="realm" value="ApplicationRealm" />
							<module-option name="usersProperties" value="file:///${jboss.server.config.dir}/users.properties" />
							<module-option name="rolesProperties" value="file:///${jboss.server.config.dir}/roles.properties" />
						</login-module>
					</authentication>
				</security-domain>