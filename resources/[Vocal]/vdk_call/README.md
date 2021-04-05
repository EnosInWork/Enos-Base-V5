# vdk_call

> Resources for FiveM developers allowing them to to integrate a call system for services (police, emergency, taxi, ...)

## If you want to support me and my work : :moneybag:[Paypal](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=B3ZE4W8Y626MA):moneybag:

## Installation

- Download the resource here : https://github.com/vodkhard/vdk_call 
- Place the folder "vdk_call" to resources folder of FiveM

## Usage

- Populate the **inService** and **callActive** variables like you want
- Use "**player:serviceOn**" and "**player:serviceOff**" events with the name of the job taken when player take is service
- Use "**call:makeCall**" event with the name of the service to trigger a call

## Notes

The `template.lua` file show you how to use it ;)
