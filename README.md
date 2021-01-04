# rpi-server
Simple home server using a Raspberry Pi 4 and an external HDD

## services
- samba
- syncthing
- jellyfin

## setup
1. `$ cp env.sh.example env.sh`
2. fill in the environment variables in env.sh
3. `# ./setup.sh`
4. `# ./start.sh`

## other
### configuring omx (hardware encoding/decoding on rpi 3/4)
Besides changing the encoder/decoder in the Jellyfin GUI, the following line should be added to `/boot/config.txt`:
- RPi4: `gpu_mem=320`
- RPi3: `gpu_mem=256`
