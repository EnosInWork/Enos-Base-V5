# esx_jobs
### Requirements
- [esx_addonaccount](https://github.com/ESX-Org/esx_addonaccount)
- [esx_skin](https://github.com/ESX-Org/esx_skin)

### Features
- Jobs: slaughterer, miner, fisherman, journalist, fueler, tailor
- Security deposit when renting a job vehicle (given back in case of crash, to the amount of damage the vehicle has already taken)
- Easy system to create jobs (samples in jobs folder)
- Item farming jobs
This addon is an easy way to have farming jobs on your server, there is no player management.

## Download & Installation

### Using [fvm](https://github.com/qlaffont/fvm-installer)
```
fvm install --save --folder=esx esx-org/esx_jobs
```

### Using Git
```
cd resources
git clone https://github.com/ESX-Org/esx_jobs [esx]/esx_jobs
```

### Manually
- Download https://github.com/ESX-Org/esx_jobs/archive/master.zip
- Put it in the `[esx]` directory

## Installation
- Import `esx_jobs.sql` into your database
- Add this into your `server.cfg`
```
start esx_jobs
```

## iZone integreation (optional)
- You can use iZone with esx_jobs by creating polynomial zones with iZone. When you finish the zone creation, take the zone name and set a Zone field on the job like so:
```
CloakRoom = {
    Zone = "miner_room", -- HERE
    Size = {x = 3.0, y = 3.0, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Marker = 1,
    Blip = true,
    Name = _U("m_miner_locker"),
    Type = "cloakroom",
    Hint = _U("cloak_change"),
    GPS = {x = 884.86, y = -2176.51, z = 29.51}
}
```
- Note that this is just to have custom zone and avoid using radius.
### [How to install and use iZone](https://github.com/izio38/iZone)

# Legal
### License
esx_jobs - jobs

Copyright (C) 2015-2020 Jérémie N'gadi

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.