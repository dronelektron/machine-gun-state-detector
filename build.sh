#!/bin/bash

PLUGIN_NAME="machine-gun-state-detector"

cd scripting
spcomp $PLUGIN_NAME.sp -o ../plugins/$PLUGIN_NAME.smx
