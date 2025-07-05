# rpi-server

Basic scripts and configs for a docker-centered home server using a Raspberry Pi 4 and an external HDD.

## services

- samba
- syncthing
- jellyfin
- deluge
- sonarr
- jackett
- radarr
- bazarr
- gluetun
- traefik
- pihole
- homeassistant

## setup

1. `$ cp .env.example .env`
2. Fill in the environment variables in `.env`
3. `$ cd seedboxsync/scripts/config`
4. `$ cp sample-sync-config.json sync-config.json`
5. Fill in `sync-config.json`
6. `$ cd -`
7. `# ./setup.sh`
8. `# docker compose up -d`

Then setup the various services through their [web uis](#web-interfaces).

### Tailscale

The setup script installs and starts [Tailscale](https://tailscale.com/) which can be used to access the server from anywhere.

Manual setup: add the Tailscale IP of the server as a DNS server to use Pi-hole as a DNS server (more info [here](https://tailscale.com/kb/1114/pi-hole/#optional-share-your-pi-hole-with-a-friend)).

### Pi-hole

Pi-hole can be used as a DNS server through Tailscale to access the web interfaces by a hostname instead of an IP and port combination.

Manual setup: add DNS records pointing to the domains specified in `docker-compose.yml`.

## usage

The server can be accessed through Tailscale.

### web interfaces

Some of the services have their own web uis, here are some default ports to access them:

- syncthing `:8384`
- jellyfin `:8096`
- deluge `:8112`
- jackett `:9117`
- sonarr `:8989`
- radarr `:7878`
- bazarr `:6767`
- pihole `:5089`
- traefik `:8080`

They can also be accessed through hostnames resolved by Pi-hole. This is done by adding `.raspi` to the service name. E.g., `jellyfin.raspi` for the jellyfin web ui. The hostnames can be changed by changing the values in `docker-compose.yml` and the DNS records in pi-hole.

## other

### configuring omx (hardware encoding/decoding on rpi 3/4)

Besides changing the encoder/decoder in the Jellyfin GUI, the following line should be added to `/boot/config.txt`:

- RPi4: `gpu_mem=320`
- RPi3: `gpu_mem=256`

If the system crashes, try using a lower value.

### resources

- mDNS
  - https://andrewdupont.net/2022/01/27/using-mdns-aliases-within-your-home-network/
- rpi reliability (reboot on crash, etc.)
  - https://www.dzombak.com/blog/2023/12/Considerations-for-a-long-running-Raspberry-Pi.html
