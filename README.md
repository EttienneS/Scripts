# Scripts

Scripts for machine configuration.

## Getting Started

Just pull the script you want and run!

## Prerequisites

Windows Machine
Powershell 5.0 or greater

## Installation

No install needed but if you want to run the script as a scheduled job at startup you can run:

```
iex ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/EttienneS/Scripts/master/create-runoncekey.ps1"))
```

This creates a runonce key on the machine.  The key will tell Windows to download the latest version of [go.ps1](./go.ps1) and execute it.

## Authors

* **Ettienne Scharneck** - *Initial work* - [EttienneS](https://github.com/EttienneS)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
