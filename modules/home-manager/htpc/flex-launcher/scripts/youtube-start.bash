#!/bin/bash

input-remapper-control --command start --device "DualSense Wireless Controller" --preset "Youtube controller"
chromium --kiosk --user-agent="Mozilla/5.0 (Linux; Tizen 2.3; SmartHub; SMART-TV; SmartTV; U; Maple2012) AppleWebKit/538.1+ (KHTML, like Gecko) TV Safari/538.1+" --app=https://youtube.com/tv