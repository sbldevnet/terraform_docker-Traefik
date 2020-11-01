# Docker Traefik Variables file

variable "traefik_conf" {
  type        = string
  default     = "/opt/traefik/traefik.yml"
  description = "Traefik Config Yaml"
}

variable "web_ui_port" {
  type        = number
  default     = 8080
  description = "TCP Port Web Dashboard. If dashboard_router is true, this port is not exposed"
}

variable "dashboard_router" {
  type        = bool
  default     = true
  description = "Enable dashboard through traefik"
}

variable "domain_name" {
  type        = string
  default     = "local"
  description = "Domain to use in Host router Rule"
}