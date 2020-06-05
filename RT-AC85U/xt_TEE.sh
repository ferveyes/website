#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage:" 1>&2
  echo "  wget https://ferveyes.com/RT-AC85U/xt_TEE.sh -O - | sh IP_OF_TEE_GATEWAY" 1>&2
  exit 1
fi

wget -O /tmp/xt_TEE.ko https://ferveyes.com/RT-AC85U/xt_TEE.ko
insmod /tmp/xt_TEE.ko

iptables -t mangle -I PREROUTING -i br0 -j TEE --gateway "$1"
iptables -t mangle -I POSTROUTING -o br0 -j TEE --gateway "$1"
