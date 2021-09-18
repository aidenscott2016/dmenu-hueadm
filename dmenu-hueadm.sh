#! /bin/env sh
IFS=

awkf(){
  awk -F"[[:space:]][[:space:]]+" "{print \$$1 }"
}

toggle() {
  if [ $1 == 'off' ]; then
    echo 'on'
  else
    echo 'off'
  fi
}

config="${HOME}/.config/hueadm/config.json"
lights=$(hueadm  -c $config lights -Ho id,name,status -s name)
lightnames=$(echo $lights | awkf 2)

selectedlight=$(dmenu <<< $lightnames)
lightid=$(echo $lights | grep -i $selectedlight | awkf 1)
lightstate=$(echo $lights | grep -i $selectedlight | awkf 3)

hueadm -c $config light $lightid $(toggle $lightstate) > /dev/null 2>&1


