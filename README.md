# ethoDocker

```bash

git clone https://github.com/fallengravity/ethoDocker

cd ethoDocker

make image
```

Now setup a service inside /etc/systemd/system/`<name>`.service:

```
[Unit]
Description=<description>
After=network.target

[Service]
User=<user>
Group=<group>
Type=simple
Restart=always
RestartSec=30s
WorkingDirectory=/home/<user>/ethoDocker
ExecStart=/usr/bin/make node

[Install]
WantedBy=default.target
```
