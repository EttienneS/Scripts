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
iex ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/EttienneS/Scripts/master/create-runoncekey.ps1"))
```

This downloads the [create-runoncekey.ps1](./create-runoncekey.ps1) script and executes it.

create-runoncekey creates a registry key on the machine that will configure the machine to download and excute the latest version of [go.ps1](./go.ps1) on machine startup.

## Authors

* **Ettienne Scharneck** - *Initial work* - [EttienneS](https://github.com/EttienneS)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
