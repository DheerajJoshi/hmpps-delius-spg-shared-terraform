global
    daemon
    stats socket /var/run/haproxy.sock mode 777 level admin
    maxconn 4096
    nbproc 1

defaults
    log global
    option  dontlognull
    timeout connect 50000
    timeout client  50000
    timeout server  50000

# From SPG to PO Frontend
frontend http-in
    bind *:8181
    mode tcp
    default_backend http-spg-server

backend http-spg-server
    timeout connect 10s
    timeout server 300s
    mode tcp
    server spg-server8181 spgw-mpx-int.sandpit.delius-core.probation.hmpps.dsd.io:8181