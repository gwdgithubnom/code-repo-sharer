#!/bin/bash
url=""
cat t.md |awk -F'[()]' '{print $2}'