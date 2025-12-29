$num_instances = 3
$os = "ubuntu2204"
$subnet = "192.168.8"
$vm_memory = 16384
$vm_cpus = 4
$extra_vars = {
    "dashboard_enabled": true,
    "helm_enabled": true,
    "metrics_server_enabled": true,    
    "kube_proxy_mode": "ipvs",
    "kube_proxy_strict_arp": true,    
    "registry_enabled": true,
    "metallb_enabled": true,
    "metallb_namespace": "metallb-system",
    "metallb_config": {
        "address_pools": {
            "primary": {
                "ip_range": [
                    "192.168.8.200-192.168.8.240"
                ],
                "auto_assign": true
            }
        
        },
        "layer2": ["primary"]
    },
    "ingress_nginx_enabled": true,
    "ingress_nginx_host_network": false,
    "ingress_publish_status_address": "",
    "local_path_provisioner_enabled": true
}