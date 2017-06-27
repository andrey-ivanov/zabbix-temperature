#!/bin/bash
version=0.2

if [[ -e /etc/zabbix/temperature.conf ]]; then
   . /etc/zabbix/temperature.conf
fi

case "$1" in
"--temperature-discovery")
    # Get the list of temperature devices
    echo -en '{\n  "data":\n  ['
    for SensorInput in $(/usr/bin/find /sys/devices/platform/ -type f -name temp*_input | sort)
    do
        SensorLabel=${SensorInput/_input/_label}
        if [[ $IgnoreSensors ]]; then
            # Check ignore list by sensor name first
            if grep -qE '('${IgnoreSensors}')' $SensorLabel; then
                continue
            fi
            # Check ignore list by path to sensor as well
            if (echo $SensorInput | grep -qE '('${IgnoreSensors}')'); then
                continue
            fi
        fi
        SensorMax=${SensorInput/_input/_max}
        echo -en "$Delimiter\n    "
        echo -en "{\"{#SENSORLABEL}\":\"$(cat ${SensorLabel})\",\"{#SENSORINPUT}\":\"${SensorInput}\",\"{#SENSORMAX}\":\"${SensorMax}\"}"
        Delimiter=","
    done
    echo -e '\n  ]\n}'
    exit 0
;;
"--fan-discovery")
    # Get the list of fan devices
    typeset -i cntLines=0
    echo -en '{\n  "data":\n  ['
    for FanInput in $(/usr/bin/find /sys/devices/platform/ -type f -name fan*_input | sort)
    do
        cntLines=${cntLines}+1
        echo -en "$Delimiter\n    "
        echo -en "{\"{#FANLABEL}\":\"Fan ${cntLines}\",\"{#FANINPUT}\":\"${FanInput}\"}"
        Delimiter=","
    done
    echo -e '\n  ]\n}'
    exit 0
;;
*)
    # This should not occur!
    echo "ERROR on `hostname` in $0"
    exit 1
;;
esac
