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

# TODO: might need to add - ca-file /usr/local/etc/haproxy/ca.pem
frontend https-in
    bind *:9001 ssl verify required crt /usr/local/etc/haproxy/server.pem
    reqadd X-Forwarded-Proto:\ https
    default_backend http-spg-balance

# The clustered MPX-ISO Hybrid Servers over http (TLS handled by frontend)
backend http-spg-balance
    redirect scheme https if !{ ssl_fc }
    option forwardfor
    option abortonclose

balance roundrobin
    server mpx-8181 spgw-mpx-int.sandpit.delius-core.probation.hmpps.dsd.io:8181
