# Radhaus: Konfigurationsdatei für den Shop-Server.
# Nur für die Zusatzaufgabe "Terraform prüfen" – es wird nichts in einer Cloud angelegt.

terraform {
  required_version = ">= 1.10"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

variable "umgebung" {
  description = "Name der Umgebung, z. B. staging oder production"
  type        = string
  default     = "staging"
}

resource "local_file" "shop_konfiguration" {
  filename = "${path.module}/shop-${var.umgebung}.conf"
  content = <<-KONFIG
    umgebung=${var.umgebung}
    versandfrei_ab=50.00
    versandpauschale=4.90
  KONFIG
  file_permission = "0644"
}
