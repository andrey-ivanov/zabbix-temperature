# Zabbix CPU temperature and fan speed monitoring

## Features:
* Auto discovery of temperature sensors
* Will trigger an alert if reported temperature is near sensor maximum
  (a difference between two values is less then 10 °C)
* Auto discovery of available fans
* Active Zabbix agent discovery and items

1. Download repository files and run to install files
```bash
cd zabbix-temperature-master
sudo bash install.sh
```
2. Import zabbix-temperature.xml on Zabbix server

## Future Tasks:
- [ ] implement CPU index renumbering for multiprocessor servers

## Special Notes:
Project zabbix-hdd-smart can be used to track SATA and NVMe disk temperatures