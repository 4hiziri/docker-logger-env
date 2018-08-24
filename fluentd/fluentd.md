# preparation

## increase max fd to 65535

```conf : /etc/security/limits.conf
root soft nofile 65535
root hard nofile 65535
* soft nofile 65535
* hard nofile 65535
```

reboot

## optimize network kernel parameters

```conf : /etc/sysctl.conf
net.core.somaxconn = 1024
net.core.netdev_max_backlog = 5000
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_wmem = 4096 12582912 16777216
net.ipv4.tcp_rmem = 4096 12582912 16777216
net.ipv4.tcp_max_syn_backlog = 8096
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 10240 65535
```

reboot or type `sysctl -p`

# install deb

```sh
curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-xenial-td-agent3.sh | sh
```

# launch daemon
`/lib/systemd/td-agent` provides start, stop, restart.

# netflow plugin for fluentd
```sh
sudo apt-get install libcurl4-openssl-dev -y
sudo apt-get install gcc -y
sudo /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-elasticsearch
sudo /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-netflow
```

fluent-gem -> td-agent-gem
fluent-plugin-netflow has bug.
use [https://github.com/4hiziri/fluent-plugin-netflow] instead.
cp files to `/opt/td-agent/embedded/lib/ruby/gems/2.5.0/gems/fluent-plugin-netfluw-0.2.8/`

# setting
`/etc/td-agent/td-agent.conf`

```conf
<source>
  @type netflow
  tag netflow.event
  port 2055
  versions [9]
</source>

<match netflow.**>
  @type file
  path /path/to/logfile
</match>
```
