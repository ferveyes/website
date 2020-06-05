#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage:" 1>&2
  echo "  wget -q -O - http://website.ferveyes.com/RT-AC85U/xt_TEE.sh | sh -s IP_OF_TEE_GATEWAY" 1>&2
  exit 1
fi

wget -q -O /tmp/xt_TEE.ko http://website.ferveyes.com/RT-AC85U/xt_TEE.ko

iptables -t mangle --flush
rmmod xt_TEE.ko
insmod /tmp/xt_TEE.ko

iptables -t mangle -I PREROUTING -i br0 -j TEE --gateway "$1"
iptables -t mangle -I POSTROUTING -o br0 -j TEE --gateway "$1"
