resource "docker_network" "homelab" {
  name = "homelab-net"
}

resource "docker_image" "ubuntu_ansible" {
  name = "geerlingguy/docker-ubuntu2204-ansible:latest"
}

resource "docker_container" "target" {
  count    = var.target_count
  name     = "target-${count.index + 1}"
  image    = docker_image.ubuntu_ansible.image_id
  hostname = "target-${count.index + 1}"

  privileged    = true
  cgroupns_mode = "host"
  command       = ["/lib/systemd/systemd"]

  tmpfs = {
    "/run"      = ""
    "/run/lock" = ""
  }

  volumes {
    container_path = "/sys/fs/cgroup"
    host_path      = "/sys/fs/cgroup"
    read_only      = false
  }

  networks_advanced {
    name = docker_network.homelab.name
  }
}
