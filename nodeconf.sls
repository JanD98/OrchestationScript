munin:
  pkg:
    - installed
/etc/munin/munin-node.conf:
  file.managed:
    - source: salt:///OrchestrationScript/munin.conf
    - user: root
    - group: root
    - mode: 777
    - template: jinja
    - defaults:
      master_ip: "^192\\.168\\.56\\.3$"
