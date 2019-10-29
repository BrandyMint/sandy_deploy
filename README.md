# Деплой для SandyApp

## Запуск

Из консоли:

`./start`

Из X-ов (рекомендуется иметь на рабочем столе): `./Sandy_Synday`

## Скрипты


### Основные

* `./bin/run.sh` - останавливает все текущие приложения, скачивает последний апдейт и запускает его.
* `./bin/pull_latest.sh` - скачивает послединй релиз из `${SERVER}${SERVER_BUILDS_PATH}` в `./downloads` и делает на него симлинк вида `./downloads/latest.zip`.
* `./bin/unpack.sh` - распаковывает последний релиз из `./downloads/latest.zip` в `./releases/ДАТА-ВРЕМЯ-ИМЯ_ПАКЕТА`.
* `./bin/start.sh` - цикл запуска приложения (`./bin/run.sh` в цикле)
* `./bin/clear.sh` - делает бэкап и удаляет текущие настройки приложения (очищает содержимое каталога `./config/*`)
* `./bin/kill.sh` - останавливает все параллельно запущенные приложения

## Структура каталога

* `./releases` - сюда складываются релизы. Каждый в своем каталоге, например: `2019-01-01-12:00:12-v0.12.146`
* `./current` - каждый раз создается заново, это symlink на текущий релиза из `./releases`
* `./downloads` - сюда (`bin/pull_latest.sh`) складвает скачанные пакеты.

## Деплой новой версии

Деплой новой версии (скачает последнюю версию с FTP, распакует и развернет в `./current`):

```
> make
```

## Ручное переключение версии

1) выходишь из этой и из цикла перезапуска (ctrl-c ctrl-c)
2) Запускаешь терминал, идешь в папку ~/SandyApp
3) В ней есть папка realeases, там лежит релизы, заходишь в любой и запускаешь от туда

# Подготовка оборудования

```
adduser sandy
cd /home/sandy
hostname sandy3
# Setup local DNS
git clone git@github.com:BrandyMint/sandy_deploy.git
# Setup VPN
```

## Настройка DNS

```
root@sandy2:~/# cat /etc/systemd/resolved.conf.d/sandy.conf
[Resolve]
Domains=sandynet sandysunday.ru
```

### Дать доступ к серверу обновлений

```
ssh-keygen
```

# Файл ~/.ssh/id_rsa.pub скопировать в домашку konstantine на office
```
