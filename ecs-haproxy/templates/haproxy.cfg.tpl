global
    daemon
    log 127.0.0.1:514  local0
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

frontend https-in
    bind *:9001 ssl verify required crt /usr/local/etc/haproxy/server.pem ca-file /usr/local/etc/haproxy/ca.pem
    default_backend http-spg-balance
    log global
    option httplog
    option forwardfor
    option abortonclose

# The clustered MPX-ISO Hybrid Servers over http (TLS handled by frontend)
backend http-spg-balance
    redirect scheme https if !{ ssl_fc }
    option forwardfor
    option abortonclose

balance roundrobin
    server mpx-8181 spgw-mpx-int.sandpit.delius-core.probation.hmpps.dsd.io:8181
