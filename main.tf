resource "aws_subnet" "pscloud-subnet" {
  for_each                    = var.pscloud_subnets_list

  vpc_id                      = var.pscloud_vpc_id
  availability_zone           = each.value.az
  cidr_block                  = each.value.cidr_block
  map_public_ip_on_launch     = (var.pscloud_type == "public") ? true : false

  tags = {
    Name                      = "${var.pscloud_company}_subnet_${var.pscloud_type}_${var.pscloud_env}_${var.pscloud_project}_${each.value.cidr_block}"
    Project                   = var.pscloud_project
  }
}

resource "aws_route_table" "pscloud-route-table" {
  vpc_id                      = var.pscloud_vpc_id

  tags = {
    Name                      = "${var.pscloud_company}_rt_${var.pscloud_type}_${var.pscloud_env}_${var.pscloud_project}"
    Project                   = var.pscloud_project
  }
}

resource "aws_route" "pscloud-route" {
  for_each                    = var.pscloud_routes_list

  route_table_id              = aws_route_table.pscloud-route-table.id
  destination_cidr_block      = each.value.cidr_block
  gateway_id                  = each.value.gateway_id
}

resource "aws_route" "pscloud-route-by-nat" {
  for_each                    = var.pscloud_routes_by_nat_list

  route_table_id              = aws_route_table.pscloud-route-table.id
  destination_cidr_block      = each.value.cidr_block
  nat_gateway_id              = each.value.nat_gateway_id
}

resource "aws_route" "pscloud-route-by-transit_gateway" {
  for_each                    = var.pscloud_routes_by_transit_gateway_list

  route_table_id              = aws_route_table.pscloud-route-table.id
  destination_cidr_block      = each.value.cidr_block
  transit_gateway_id              = each.value.transit_gateway_id
}

resource "aws_route_table_association" "pscloud-rt-assoc" {
  for_each                = aws_subnet.pscloud-subnet

  subnet_id               = each.value.id
  route_table_id          = aws_route_table.pscloud-route-table.id
}

#resource "aws_route_table_association" "pscloud-rt-assoc" {
#  count                   = length(aws_subnet.pscloud-subnet)
#  subnet_id               = aws_subnet.pscloud-subnet[count.index].id
#  route_table_id          = aws_route_table.pscloud-route-table.id
#}