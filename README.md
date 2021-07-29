# rpi-server
Basic scripts and configs for a docker-centered home server using a Raspberry Pi 4 and an external HDD.

## services
- samba
- syncthing
- jellyfin
- deluge

## setup
1. `$ cp .env.example .env`
2. fill in the environment variables in `.env`
3. `# ./setup.sh`
4. `# ./start.sh`

## usage
### web interfaces
Some of the services have their own web uis, here are some default ports to access them:
- syncthing `:8384`
- jellyfin `:8096`
- deluge `:8112`
- jackett `:9117`
- sonarr `:8989`

## other
### configuring omx (hardware encoding/decoding on rpi 3/4)
Besides changing the encoder/decoder in the Jellyfin GUI, the following line should be added to `/boot/config.txt`:
- RPi4: `gpu_mem=320`
- RPi3: `gpu_mem=256`

If the system crashes, try using a lower value.
