module "data_subnet" {
  source = "./data_subnet"
  token  = var.yandex_token
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  vpc_id    = var.vpc_id
}

module "create_vm" {
  source = "./create_vm"
  yandex_token = var.yandex_token
  yandex_cloud_id = var.yandex_cloud_id
  yandex_folder_id = var.yandex_folder_id
  subnet_id = var.selected_subnet_id
  zone = var.default_zone
  ssh_public_key_path = var.ssh_public_key_path
  ssh_private_key_path = var.ssh_private_key_path
}
