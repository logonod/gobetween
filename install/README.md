# Config && Run
example toml config file

```bash
[logging]
level = "info"   # "debug" | "info" | "warn" | "error"
output = "stdout" # "stdout" | "stderr" | "/path/to/gobetween.log"

[api]
enabled = false  # true | false

[defaults]
max_connections = 50              # Maximum simultaneous connections to the server
client_idle_timeout = "30s"        # Client inactivity duration before forced connection drop
backend_idle_timeout = "30s"       # Backend inactivity duration before forced connection drop
backend_connection_timeout = "10s" # Backend connection timeout (ignored in udp)

[servers]

[servers.tcp]
protocol = "tcp"
bind = "0.0.0.0:443"

  [servers.tcp.discovery]
  kind = "static"
  static_list = [
      "xxx.xxx.xxx.xxx:443",
      "xxx.xxx.xxx.xxx:443",
      "xxx.xxx.xxx.xxx:443"
  ]

  [servers.tcp.healthcheck]
  kind = "ping"
  interval = "4s"
  ping_timeout_duration = "500ms"

[servers.udp]
protocol = "udp"
bind = "0.0.0.0:443"

  [servers.udp.udp]
  max_responses = 5

  [servers.udp.discovery]
  kind = "static"
  static_list = [
      "xxx.xxx.xxx.xxx:443",
      "xxx.xxx.xxx.xxx:443",
      "xxx.xxx.xxx.xxx:443"
  ]

  [servers.udp.healthcheck]
  kind = "exec"
  interval = "4s"
  timeout = "1s"
  
  exec_command = "/home/ubuntu/gobetween/install/ping.sh"  # (required) command to execute
  exec_expected_positive_output = "1"           # (required) expected output of command in case of success
  exec_expected_negative_output = "0"           # (required) expected output of command in case of failure

```

example ping.sh

```bash
#!/usr/bin/env bash
if ping -c 1 -W 1 $1 &> /dev/null
then
  echo -n 1
else
  echo -n 0
fi
```

chmod ping.sh

```bash
chmod +x ping.sh
```

run gobetween

```bash
sudo ./gobetween -c /home/ubuntu/gobetween/install/config.toml
```