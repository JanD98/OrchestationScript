apache2:
  pkg:
    - installed 

munin:
  pkg:
    - installed 

/var/www/munin:
  file.directory:
    - user: munin
    - name: /var/www/munin
    - group: munin
    - mode: 777 

/etc/munin/apache.conf:
  file.managed:
    - source: salt://munin/apache.conf
    - user: root
    - group: root
    - mode: 777 

/etc/apache2/conf-available/munin.conf:
  file.managed:
    - source: salt://munin/munin.conf
    - user: root
    - group: root
    - mode: 777 

/etc/apache2/conf-enabled/munin.conf:
  file.managed:
    - source: salt://munin/munin.conf
    - user: root
    - group: root
    - mode: 777 

/etc/munin/munin.conf:
  file.managed:
    - source: salt://munin/muninmaster.conf
    - user: root
    - group: root
    - mode: 777
    - template: jinja
    - defaults:
      node_ip: "10.0.0.9"

rsyslog:
  pkg:
    - installed

/etc/rsyslog.conf:
  file.managed:
    - source: salt://rsyslog/rsyslogmaster.conf
    - user: root
    - group: root
    - mode: 777

oracle-ppa:
  pkgrepo.managed:
    - humanname: WebUpd8 Oracle Java PPA repository
    - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
    - dist: trusty
    - file: /etc/apt/sources.list.d/webupd8team-java.list
    - keyid: EEA14886
    - keyserver: keyserver.ubuntu.com

oracle-license-select:
  debconf.set:
    - name: oracle-java8-installer
    - data:
        'shared/accepted-oracle-license-v1-1': {'type': 'boolean', 'value': True }

oracle-java8-installer:
  pkg:
    - installed
    - require:
	- pkgrepo: oracle-ppa

