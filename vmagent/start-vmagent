#!/usr/bin/with-contenv bashio
set -e

REMOTE_URL=$(bashio::config 'remoteWriteURL')
ARGS=$(bashio::config 'additionalArguments')


HTTPAUTHARGS=""
if bashio::config.true 'enableHTTPAuth'
then
    bashio::log.info "Use httpAuth for Victoria Metrics"
    HTTPAUTHARGS="-httpAuth.username=$(bashio::config 'username') -httpAuth.password=$(bashio::config 'password')"
fi
if bashio::config.true 'remoteWriteHTTPAuth'
then
    bashio::log.info "Use remote write httpAuth for Victoria Metrics"
    HTTPAUTHARGS="-remoteWrite.basicAuth.username=$(bashio::config 'username') -remoteWrite.basicAuth.password=$(bashio::config 'password')"
fi


TCPARG=""
if bashio::config.true 'enableTCP6'
then
    TCPARG='-enableTCP6'
fi


PROMETHEUSARGS=""
bashio::log.info "Use promscrape config for Victoria Metrics"
SCHEME="http"
if bashio::config.true 'prometheusScrapeHTTPS'
then
    SCHEME="https"
fi
bashio::log.info "Scheme: $SCHEME"

echo '{"token": "'$(bashio::config 'longelivedToken')'", "scheme": "'$SCHEME'", "homeassistantUrl": "'$(bashio::config 'homeassistantUrl')'", "prometheusScrapeInterval": "'$(bashio::config 'prometheusScrapeInterval')'", "prometheusScrapeTimeout": "'$(bashio::config 'prometheusScrapeTimeout')'", "enablePrometheusScrape": '$(bashio::config 'enablePrometheusScrape')', "enableNodeExporterScrape": '$(bashio::config 'enableNodeExporterScrape')',  "source": "'$(bashio::config 'source')'", "dropMetricsRegex": "'$(bashio::config 'dropMetricsRegex')'"  }' | tempio -template /prometheus.tpl -out /prometheus.yml
bashio::log.info "Yaml file generated"
cat  /prometheus.yml
PROMETHEUSARGS="-promscrape.config /prometheus.yml"

bashio::log.info "Starting Victoria Metrics with remote write to $REMOTE_URL"
bashio::log.info "Starting Victoria Metrics Agent with args set to $ARGS"
/vmagent-prod -remoteWrite.tmpDataPath /share/vmagent-data -remoteWrite.url "$REMOTE_URL" $TCPARG $HTTPAUTHARGS $PROMETHEUSARGS $ARGS
#/vmagent-prod -remoteWrite.url "$REMOTE_URL" $TCPARG $HTTPAUTHARGS $PROMETHEUSARGS $ARGS