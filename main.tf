provider "aws" {
  region  = var.region
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.namespace}-${var.owner}"
  public_key = file(var.ssh_public_key)
}

resource "aws_instance" "minikube" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type_worker
  key_name      = aws_key_pair.deployer.key_name
  associate_public_ip_address  = true
  user_data     = templatefile("user-data.sh", {

  })
  subnet_id              = aws_subnet.hackathon_subnet[0].id
  vpc_security_group_ids = [aws_security_group.hackathon_sg.id]

  root_block_device{
    volume_size           = "50"
    delete_on_termination = "true"
  }

   ebs_block_device  {
    device_name           = "/dev/xvdd"
    volume_type           = "gp2"
    volume_size           = "50"
    delete_on_termination = "true"
  }


  tags = {
    Name       = "${var.namespace}-hackathon"
    owner      = var.owner
    created-by = var.created-by
  }
}