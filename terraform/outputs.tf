output "target_container_names" {
  value = docker_container.target[*].name
}
