variable "vm_ip" {
  type        = string
  description = "IP address of the VirtualBox VM"
}

variable "vm_user" {
  type        = string
  description = "Username for SSH access to the VM"
}








/**variable "external_port" {
  type    = number
  default = 8080
  validation {
    condition     = can(regex("8080|80", var.external_port))
    error_message = "Port values can only be 8080 or 80."
  }
}**/
