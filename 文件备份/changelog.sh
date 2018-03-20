#!/bin/bash

changelog=`cat gitLog.txt | sed 's/RANGE_CHANGELOG=//g'`
echo $changelog