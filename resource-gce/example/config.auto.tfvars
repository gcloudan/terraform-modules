project_id = "cert-pr"
tags       = ["web"]
labels = {
  preemtible = true
}
ip_cidr_range           = "10.1.2.0/24"
machine_type            = "e2-highcpu-32"
name                    = "cert-pr-instance"
secondary_ip_cidr_range = "192.168.100.0/24"
zone                    = "australia-southeast1-a"
subnetwork_project      = "cert-pr"
subnetwork              = "test-subnet"