all:
	./bin/pull_latest.sh && ./bin/unpack.sh

report:
	scp -r config/ konstantin@office.brandymint.ru:/home/konstantin/logs/$(hostname)-$(date '+%Y-%m-%d-%H:%M:%S')
