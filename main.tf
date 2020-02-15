resource "aws_subnet" "pscloud-subnet" {
  count                       = length(var.pscloud_subnets_list)

  vpc_id                      = var.pscloud_vpc_id
  availability_zone           = var.pscloud_subnets_list[count.index].az
  cidr_block                  = var.pscloud_subnets_list[count.index].cidr_block
  map_public_ip_on_launch     = (var.pscloud_type == "public") ? true : false

  tags = {
    Name                      = "${var.pscloud_company}_subnet_${var.pscloud_type}_${var.pscloud_env}"
    Project = var.pscloud_project
  }
}

resource "aws_route_table" "pscloud-route-table" {
  vpc_id                      = var.pscloud_vpc_id

  tags = {
    Name                      = "${var.pscloud_company}_rt_${var.pscloud_type}_${var.pscloud_env}"
    Project                   = var.pscloud_project
  }
}

resource "aws_route" "pscloud-route" {
  count                       = length(var.pscloud_routes_list)

  route_table_id              = aws_route_table.pscloud-route-table.id
  destination_cidr_block      = var.pscloud_routes_list[count.index].cidr_block
  gateway_id                  = var.pscloud_routes_list[count.index].gateway_id
}


resource "aws_route_table_association" "pscloud-rt-assoc" {
  count                   = length(aws_subnet.pscloud-subnet)
  subnet_id               = aws_subnet.pscloud-subnet[count.index].id
  route_table_id          = aws_route_table.pscloud-route-table.id
}