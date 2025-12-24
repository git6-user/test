resource "aws_ec2_transit_gateway" "test" {
  description = "test"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
  for_each = toset(data.aws_vpcs.my-vpcs.ids)
  depends_on = [ aws_ec2_transit_gateway.test ]
  subnet_ids         = data.aws_subnets.vpcsubnets[each.value].ids
  transit_gateway_id = aws_ec2_transit_gateway.test.id
  vpc_id             = each.key
}