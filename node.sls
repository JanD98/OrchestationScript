munin:
  pkg:
    - installed

/etc/munin/munin-node.conf:
  file.managed:
    - source: salt://munin/munin-node.conf
    - user: root
    - group: root
    - mode: 777
    - template: jinja
    - defaults:
      master_ip: "^10\\.0\\.0\\.16$"

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
      master_ip: "@10.0.0.16"

"add key":
  cmd.run:
    - name: 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'

"add repo":
  cmd.run:
    - name: 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'

"install docker":
  cmd.run:
    - name: 'apt-get update'
   
  pkg.installed:
    - name: docker-ce
    - refresh: True
    - pkg: docker-ce

"start docker":
  service.running:
    - name: docker
    - reload: True
    - init_delay: 10
    - enable: True
    - require:
        - pkg: "install docker"

"install wordpress_db":
  cmd.run:
    - name: 'docker run -e MYSQL_ROOT_PASSWORD=test -e MYSQL_DATABASE=wordpress --name wordpressdb -v "$PWD/database":/var/lib/mysql -d mariadb:latest'

"install wordpress":
  cmd.run:
    - name: 'docker run -e WORDPRESS_DB_PASSWORD=test --name wordpress --link wordpressdb:mysql -p 10.0.0.17:80:80 -v "$PWD/html":/var/www/html -d wordpress'
