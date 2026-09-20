#!/bin/bash

input-remapper-control --command stop-all
kill -9 `pidof chromium`