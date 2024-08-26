#!/bin/bash

host=$(hostname)
state=$(nodetool status -r | grep $host | cut -f1 -d' ' )
if [ $state == "UN" ]
then
	exit 0;
else
	exit 1;
fi