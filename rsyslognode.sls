rsyslog:
  pkg:
    - installed
 
/etc/rsyslog.conf:
  file.managed:
    - source: salt://rsyslog/rsyslognode.conf
    - user: root
    - group: root
    - mode: 777
    - template: jinja
    - defaults:
      master_ip: "@10.0.0.8"   
