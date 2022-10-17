#!/bin/bash
if [[ -z "$SRCDS_TOKEN" ]]
then
  echo "Musisz podać token Steam SRCDS (SRCDS_TOKEN)"
  exit 1
fi
/home/steam/csgo/srcds_run -game csgo -console -usercon +sv_setsteamaccount $SRCDS_TOKEN -net_port_try 1