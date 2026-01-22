### home assistant
to enable access through a reverse proxy, append these lines to ./homeassistant/configuration.yaml
``` yaml
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 192.168.1.0/24
    - 172.18.0.0/24
    - 127.0.0.1
    - ::1
    - fe80::/64
    - fe00::/64
    - fd00::/64
```
