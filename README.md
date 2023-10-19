To deploy on MicroK8s, you'll need:
 * Juju 3 installed.
 * A Juju controller created.

For more information about how to install Juju, see
[Get started with Juju](https://juju.is/docs/juju/get-started-with-juju).


Make sure you have the following plugins enabled:
```
sudo microk8s enable dns storage ingress
IPADDR=$(ip -4 -j route get 2.2.2.2 | jq -r '.[] | .prefsrc')
sudo microk8s enable metallb:$IPADDR-$IPADDR
```

There are three environments defined here. To deploy development, assuming
you've done the above:

```
cd zinc/environments/dev
terraform init
terraform plan
terraform apply
```

To inspect the environment with Juju, run:
```
juju switch dev-zinc
juju status
```

Then to test the service, run:
```
curl -v http://dev.operatorinc.org/dev-zinc-zinc/ui/ --resolve dev.operatorinc.org:80:${IPADDR}
```

If you want to visit the service in a browser, add the value of `$IPADDR` from
above to your `/etc/hosts` file, and then browse to the URL above. You can
login with the 'admin' user ID using the password retrieved by running:
```
juju run zinc/0 get-admin-password --wait 1m
```

To deploy the staging or production environment, you'll need to define some
environment variables. This could be done by creating a file and sourcing it
(e.g. named '.terraform-secrets', which will be ignored by git, which is what
you since it will contain secrets).

```
export TF_VAR_acme_email=someemail@somedomain.com
# The AWS credentials will need to be associated with an account
# that has access to request TLS certificates via Route53 for the
# domain specified as 'external_hostname' on the acme charm.
export TF_VAR_aws_access_key_id=blah
export TF_VAR_aws_secret_access_key=blah
export TF_VAR_kratos_microsoft_tenant_id=blah
export TF_VAR_kratos_client_secret=blah
```

In a production setting, these would likely come from a Vault instance.
