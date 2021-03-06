# Деплой для SandyApp

## Запуск

### Из консоли

Автоматически скачивается последняя версия, разворачивается и запускается в
цикле:

`make`

Из X-ов (рекомендуется иметь на рабочем столе): `./Sandy.desktop`

## Обновление

Загрузка и развертывание последней доступной версии приложения:

> make update

## Отправка отчёта на сервер

В случае если программа завершилась не успешно или разработчики просят логи,
запускайте:

> make report

## Очистить конфиг (предварительно делается бекап)

> make clear

### Основные

* `./bin/run.sh` - останавливает все текущие приложения, скачивает последний апдейт и запускает его.
* `./bin/start.sh` - цикл запуска приложения (`./bin/run.sh` в цикле)
* `./bin/clear.sh` - делает бэкап и удаляет текущие настройки приложения (очищает содержимое каталога `./config/*`)
* `./bin/kill.sh` - останавливает все параллельно запущенные приложения

## Структура каталога

* `./releases` - сюда складываются релизы. Каждый в своем каталоге, например: `2019-01-01-12:00:12-v0.12.146`
* `./current` - каждый раз создается заново, это symlink на текущий релиза из `./releases`
* `./downloads` - сюда (`bin/pull_latest.sh`) складвает скачанные пакеты.
* `./log

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

* Установить [`Ubuntu 18.04 LTS`](https://ubuntu.com/download/desktop/thank-you?country=RU&version=18.04.3&architecture=amd64)
* Добвить пользователя с именем `sandy`
* Включить автологин `sandy`
* Выключить screensaver - (`Settings` -> `Power`)
* Выключить screenlock - (`Settings` -> `Privacy`)
* Выключить автообновление Ubuntu
* Установить librealsense так - https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md (если dkms будет ругаться, его можно не ставить)
* Установить ssh-server: `apt-get install openssh-server`

## Возможные проблемы

* [PCIe Bus error severity=Corrected](https://www.linux.org.ru/forum/linux-hardware/12585679?cid=13444394)

## Установка автоматического развертывания

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
