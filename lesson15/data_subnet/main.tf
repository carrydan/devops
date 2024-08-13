terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.70"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

variable "token" {
  description = "Yandex.Cloud OAuth token"
  type        = string
}

variable "cloud_id" {
  description = "ID of the Yandex.Cloud"
  type        = string
}

variable "folder_id" {
  description = "ID of the folder в Yandex.Cloud"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

data "yandex_vpc_network" "my_vpc" {
  network_id = var.vpc_id
}

data "yandex_vpc_subnet" "all_subnets" {
  for_each = toset(data.yandex_vpc_network.my_vpc.subnet_ids)
  subnet_id = each.key
}