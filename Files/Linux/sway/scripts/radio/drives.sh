#!/bin/bash
sudo cryptsetup open /dev/sda games
sudo mount /dev/mapper/games /mnt/games

sudo cryptsetup open /dev/sdb media
sudo mount /dev/mapper/media /mnt/media
