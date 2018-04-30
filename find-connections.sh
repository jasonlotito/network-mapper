#!/bin/bash

rm -f ./connected_hosts

function search_for { cat unique_connections |  grep $1 | sort | uniq | xargs; } 

function get_hostname {
        host $1 | awk '{print $NF}'
}


function process_ips {
        echo "$@" >> connected_hosts
        for conn in "$@"
        do
                ip=`echo $conn | cut -f1 -d:`
                get_hostname $ip >> connected_hosts
        done
}

function find {
        found=`search_for $1`
        process_ips $found
}

find :11211
find :3306
find :5672
find :6379
find :80

cat connected_hosts
