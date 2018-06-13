rsyslog:
  pkg:
    - installed

/etc/rsyslog.conf:
  file.managed:
    - source: salt://rsyslog/rsyslogmaster.conf
    - user: root
    - group: root
    - mode: 777
 
