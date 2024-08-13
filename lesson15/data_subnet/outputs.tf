output "subnets_info" {
  value = {for s in data.yandex_vpc_subnet.all_subnets : s.subnet_id => {
    id   = s.id
    name = s.name
    zone = s.zone
  }}
}