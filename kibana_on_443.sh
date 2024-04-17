sudo setcap cap_net_bind_service=+epi /usr/share/kibana/bin/kibana
sudo setcap cap_net_bind_service=+epi /usr/share/kibana/bin/kibana-plugin
sudo setcap cap_net_bind_service=+epi /usr/share/kibana/bin/kibana-keystore
sudo setcap cap_net_bind_service=+epi /usr/share/kibana/node/bin/node





CapabilityBoundingSet=CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_BIND_SERVICE
PrivateUsers=false