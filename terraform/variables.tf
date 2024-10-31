################################################################################
# Yandex IDs
variable "yandex_cloud_id" {
  default = "b1gah11c321co65l2apf"
}

variable "yandex_folder_id" {
  default = "b1g73kf911qh20t72eeb"
}

variable "yandex_compute_default_zone" {
  default = "ru-central1-a"
}

variable "subnet" {
    type = list(string)
    default = [ "ru-central1-a","ru-central1-b", "ru-central1-d" ]
  
}


variable "cidr" {
    type        = map(list(string))
    default     = {
      test = [ "192.168.10.0/24", "192.168.20.0/24", "192.168.30.0/24" ]
    }
  
}
