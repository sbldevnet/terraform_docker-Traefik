# Docker Traefik

resource "docker_image" "traefik" {
  name         = "traefik:latest"
  keep_locally = true
}

resource "docker_container" "traefik" {
  image     = docker_image.traefik.latest
  name      = "traefik"
  hostname  = "rpi_traefik"
  restart   = "unless-stopped"
 
  ports {
    internal = 80
    external = 80
  }
  ports {
    internal = 443
    external = 443
  }
  dynamic "ports" {
    for_each = var.dashboard_router ? [] : [1]
    content {
      internal = 8080
      external = var.web_ui_port
    }
  }

  volumes {
    host_path       = "/var/run/docker.sock"
    container_path  = "/var/run/docker.sock"
    read_only       = true
  }

  # Only create config bind mount if exists traefik.yml file
  dynamic "volumes" {
    for_each = fileexists(var.traefik_conf) ? [1] : []
    content {
      host_path       = var.traefik_conf
      container_path  = "/etc/traefik/traefik.yml"
    }
  }

  command = [ 
    # Global 
    "--accesslog=true", 
    "--api.insecure=true", 
    # Docker
    "--providers.docker", 
    "--providers.docker.exposedbydefault=false",
    # Entrypoints
    "--entryPoints.web.address=:80",
    "--entryPoints.websecure.address=:443"
    ]

  # Access Dashboard throught traefik
  dynamic "labels" {
    for_each = var.dashboard_router ? [1] : []
    content {
      label = "traefik.enable"
      value = "true"
    }
  }
  dynamic "labels" {
    for_each = var.dashboard_router ? [1] : []
    content {
      label = "traefik.http.routers.traefik.rule"
      value = "Host(`traefik.${var.domain_name}`)"
    }
  }
  dynamic "labels" {
    for_each = var.dashboard_router ? [1] : []
    content {
      label = "traefik.http.routers.traefik.entrypoints"
      value = "web"
    }
  }
  dynamic "labels" {
    for_each = var.dashboard_router ? [1] : []
    content {
      label = "traefik.http.services.traefik.loadbalancer.server.port"
      value = "8080"
    }
  }
}