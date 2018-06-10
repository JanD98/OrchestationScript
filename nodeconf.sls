munin:
  pkg:
    - installed
/etc/munin/munin-node.conf:
  file.managed:
    - source: salt://home/jandeman/automation/OrchestrationScript/munin.conf
    - user: root
    - group: root
    - mode: 777
    - template: jinja
    - defaults:
      custom_var: "^192\.168\.56\.3$"
