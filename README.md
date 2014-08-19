# github-status-hue

A fun app to blink some lights depending on GitHub Status

## Usage

You'll need to grab credentials for you Hue Bridge, and set them as environment
variables. This ships with Foreman by default, so you can drop variables in `.env` for
testing.

* Details on grabbing Hue Credentials: http://blog.paulshi.me/technical/2013/11/27/Philips-Hue-Remote-API-Explained.html
* Configure which lights to kick on and off. Set them up in `config/lights.yaml`. An example has been provided.
* Set the following ENV variables:
```
HUE_BRIDGE_ID
HUE_ACCESS_TOKEN
RSS_POLL_TIME
```
* Start it up!
  * `foreman start` for dev
  * heroku makes a good deployment option

