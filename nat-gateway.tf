# NAT gateway

resource "aws_nat_gateway" "nat-gateway {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "nat-gateway"
  }


  depends_on = [aws_internet_gateway.gw]
}