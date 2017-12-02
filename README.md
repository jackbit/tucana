
## {WIP} Tucana

Simple monitoring system with database series to monitor multiple servers in one dashboard and written by Crystal-lang.org

#### Code Usage

##### Operation System

```
# Linux
Tucana::OS.name
=> Ubuntu 16.04.2 LTS xenial

Tucana::OS.linux?
=> true

# MacOS
Tucana::OS.name
=> Mac OS X 10.12.6

Tucana::OS.macos?
=> true

# Else
Tucana::OS.name
=> Unknown
```

##### GOAL

Helpers (App) ==> Agents (Shipper) ==> Spooler (Receiver) ==> (Influx?) ==> Dashboard