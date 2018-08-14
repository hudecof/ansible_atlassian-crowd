# Role Name

Role to help install or update the Atlassian Crowd.

## Requirements

For running Atlassian Confluence you need a little bit more

- java
- database
- init script

*java* is out of scope for this playbook. I can't force you to install 
any version of java on your server. Use any existing java roles to do that.
I have my own role `hudecof.java` to do that.

You could prefer another  *database* as me. So this is out of scope too.  

The *tar.gz* version do not have startup script. I use `supervisord` to do this job.
I will generate template for `supervisord` and `init.d` and put it into *installation directory* directory.

If you are updating, shutdown you old instance manually. This role do not handle this!.
It will just setup your new instance with your customizations.

## Role Variables

`atlassian_crowd_version` is the version you want to install. This is the only one variable you need to change, the others are optional.

`atlassian_crowd_baseurl` is the URL where you can find the *tar.gz* files. If you have your own mirror, change it.

`atlassian_crowd_basedir` is path where to download nad extract the *tar.gz* file, defaults to `/opt/atlassian`.

`atlassian_crowd_home` is the `confluence.home`, aka you data directory.

`atlassian_crowd_user`, `atlassian_crowd_uid`, `atlassian_crowd_group`, `atlassian_crowd_gid` are variables to setup dedicated user to run the instance 

`atlassian_crowd_server_xml` is list of changes to `server.xml` It uses XPath to edit/add/remoce exiting properties.

    atlassian_crowd_server_xml:
    - xpath: /Server/Service/Connector
      ensure: present
      attribute: proxyPort
      value: 443
    - xpath: /Server/Service/Connector
      ensure: present
      attribute: scheme
      value: https

`atlassian_crowd_java_opts` is the list of custom *JAVA_OPTS* properties. At this moment you can't change the existing one ;(

`atlassian_crowd_build_properties` is to change **build.properties** file.

    atlassian_crowd_build_properties:
	- key: crowd.tomcat.connector.port
	  value:  9999


In version 2.8.3 a bellow there is no possibility to run application in foreground.
If you want to use a supervisor, follow the changes in this ticket https://jira.atlassian.com/browse/CWD-4318

## Dependencies

This role depens on the `cmprescott.xml` role/library.

## Example Playbook

    - hosts: atlassian
      roles:
         - cmprescott.xml
         - hudecof.atlassian-crowd

## License

BSD

## Author Information

Peter Hudec