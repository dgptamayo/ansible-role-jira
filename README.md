# Ansible Role: JIRA

An Ansible Role that installs and configures JIRA Software on RHEL/CentOS

## Requirements
- Java

## Optional components
- PostgreSQL
- HAProxy

## Role Handlers
- jira

## Role Variables
|Name|Default|Description|
|----|-------|-----------|
|`atlassian_data_dir`|`/var/atlassian/application-data`|Directory where JIRA application home directory will be created|
|`jira_version`|`7.2.2`|Version of JIRA to install|
|`jira_install_dir`|`/opt/atlassian/jira`|Installation directory where JIRA application files and libraries will be extracted|
|`jira_download_base`|http://www.atlassian.com/software/jira/downloads/binary|Base URL where JIRA package will be downloaded from (excludes the actual package name)|
|`jira_user`|jira|User to be used to run the JIRA process|
|`jira_group`|jira|Group for the `jira_user`|
|`jira_uid`|3300|UID of `jira_user`|
|`jira_gid`|3300|GID of `jira_group`|
|`jira_jvm_min_mem`|384m|Minimum JVM heap space allocated for JIRA|
|`jira_jvm_max_mem`|784m|Maximum JVM heap space allocated for JIRA|
|`jira_jvm_custom_options`|empty|Optional JIRA JVM properties. See [list of recognized system properties for JIRA applications](https://confluence.atlassian.com/adminjiraserver071/recognized-system-properties-for-jira-applications-802593121.html)|
|`jira_proxy_name`| false | All `jira_proxy_*` variables are used for running [JIRA over SSL or HTTPS](https://confluence.atlassian.com/adminjiraserver071/running-jira-applications-over-ssl-or-https-802593051.html)|
|`jira_proxy_port`|false||
|`jira_proxy_scheme`|false||

# Example playbook
```
---
- hosts: servers
  roles:
  - ansible-role-jira
```
## Run the tests
This role includes [Molecule](http://molecule.readthedocs.io/en/latest/) test framework and uses _Serverspec_ to verify the installation and configuration of JIRA software

Make sure you have the following prerequisites installed:

### Verifier
- [Serverspec](http://serverspec.org/)

### Driver
- [Vagrant](http://docs.vagrantup.com/v2)

### Provider
- [VirtualBox](https://www.virtualbox.org)

Install molecule using pip:
```
$ pip install molecule
```

To set up and test the role:

```
$ molecule test
```

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`. Make sure to update this `README` file with the description of the new script(s)
3. Commit your changes: `git commit -am 'New scripts'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## License
Apache 2.0


