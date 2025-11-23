# Home Assistant Add-on : vmagent process to send metrics to VictoriaMetrics backend



If you are looking for an efficient and easy to use way for long term storage of your Home Assistant data - just use VictoriaMetrics.

This add-on makes it easy to scrape (i.e. fetch) metrics locally, cache them in a temporary database, and send them to your centralized Victoria Metrics Time Series Database as soon as is is reachable, thus allowing to have full data even if the database is down or unreachable at times.

This add-on runs on ARM64 systems like Raspberry Pi 4 and many others (armhf, armv7, aarch64, amd64).
Inspired by (initially cloned from) https://github.com/lapo-luchini/homeassistant-addon-vmagent



## Installation and configuration

1. Add the reposity. (Quick link: [![Open your Home Assistant instance and show the Supervisor add-on store.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Finfradom%2Finfradom-ha-vmagent-addon) )
    * **Add the reposity** (click 3 dots on the top right of the screen). Reposity URL: *https://github.com/infradom/infradom-ha-vmagent-addon*
    * Refresh/reload your browser tab/window

2. **Install** the add-on:
    * Find, and **install** the Victoria Metrics Agent add-on

3. Make sure your (remote) victoriametrics backend is running and reachable

4. Configure Victoria Metrics agent
   > Read the [addon documentation](DOCS.md) which can also be found on the **Documentation tab** of the [Victoria Metrics Agent addon](https://my.home-assistant.io/redirect/supervisor_store/) in the Home Assistant settings.
   * Use the dropMetricsRexex field to specify metrics that need to be dropped: example 'entity_available|last_updated_time_seconds|state_change_created|state_change_total' (with quotes seems to work)
   * Homeassistant URL needs to be entered without scheme: ip_or_name:8123
   * Either HTTPAuth or remoteWriteHTTPAuth can be used to apply the username and password fields (unclear when which option works). I use remoteWriteHTTPAuth, my victoriametrics server is behind an authenticating reverse proxy

5. **Add the *prometheus* integration** to your Home Assistant configuration (or alternatively, not tested, the *influxdb* integration). I use the prometheus scaping/pull model locally, mainly because entities that do not change frequently are logged periodically. 
    > Don't forget to restart Home Assistant!

6. **Start** the *Victoria Metrics* add-on



Well done! You can install and configure Grafana or similar to check data is being logged.
