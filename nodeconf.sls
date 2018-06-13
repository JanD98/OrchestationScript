munin:
  pkg:
    - installed

/etc/munin/munin-node.conf:
  file.managed:
    - source: salt://munin-node.conf
    - user: root
    - group: root
    - mode: 777
    - template: jinja
    - defaults:
      master_ip: "^10\\.0\\.0\\.8$"
