# Scripts

Scripts for machine configuration.

## Getting Started

Just pull the script you want and run!

## Prerequisites

* Windows
* Powershell 5.0 or greater

## Installation

No install needed but if you want to run the primary ([go.ps1](./go.ps1)) script as a scheduled job at startup you can run:

``` Powershell
powershell -command "iex (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/EttienneS/Scripts/master/configure-autostart.ps1')"
```

This downloads the [configure-autostart.ps1](./configure-autostart.ps1) script and executes it.

configure-autostart creates a registry key on the machine that will configure the machine to download and excute the latest version of [go.ps1](./go.ps1) on machine startup.

Running [go.ps1](./go.ps1) can also be done once off by running:

``` Powershell
powershell -command "iex (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/EttienneS/Scripts/master/go.ps1')"
```

This downloads and executes the script.

## Authors

* **Ettienne Scharneck** - *Initial work* - [EttienneS](https://github.com/EttienneS)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
