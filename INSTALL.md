1. Настроить VPN
2. Установить SandyApp
3. Настроить имя (sandy*) и DNS


```
root@sandy2:~/SandyApp# cat /etc/systemd/resolved.conf.d/sandy.conf
[Resolve]
Domains=sandynet sandysunday.ru
```
