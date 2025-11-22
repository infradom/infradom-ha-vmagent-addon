global:
  scrape_interval: 60s
  scrape_timeout: 20s
  external_labels:
    source: '{{.source}}'

scrape_configs:
  - job_name: 'vmagent'
    static_configs:
      - targets:
          - localhost:8429
        labels:
          instance: '{{regexReplaceAll ":[0-9]+$" .homeassistantUrl ":8429"}}'

{{if .enableNodeExporterScrape}}
  - job_name: 'node_exporter'
    static_configs:
      - targets:
          - '{{regexReplaceAll ":[0-9]+$" .homeassistantUrl ":9100"}}'
{{end}}


{{if .enablePrometheusScrape}}
  - job_name: 'hass'
    scrape_interval: '{{.prometheusScrapeInterval}}'
    scrape_timeout: '{{.prometheusScrapeTimeout}}'
    metrics_path: /api/prometheus
    metric_relabel_configs:
      - action: drop_metrics
        regex: '{{.dropMetricsRegex}}' 
    authorization:
      credentials: "{{.token}}"
    scheme: {{ .scheme }}
    static_configs:
      - targets:
          - '{{.homeassistantUrl}}'
{{end}}

