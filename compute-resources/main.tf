##################################################################################
### Instance profile and role for the cluster ####################################
##################################################################################


resource "aws_iam_instance_profile" "instance_profile" {
  name = "k8s-cluster-instance-profile"
  role = aws_iam_role.k8s_cluster.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "read_only" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:Describe*",
      "s3:Get*",
      "s3:List*",
      "s3:Describe*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "k8s_cluster" {
  name               = "r_k8s-cluster"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.k8s_cluster.name
  policy_arn = aws_iam_policy.k8s_iam_cluster_policy.arn
}

resource "aws_iam_policy" "k8s_iam_cluster_policy" {
  name        = "p_k8s-cluster"
  description = "IAM policy for k8s cluster"
  policy      = data.aws_iam_policy_document.read_only.json
}



##################################################################################
### Ec2 intances for the cluster #################################################
##################################################################################



resource "aws_instance" "k8s_api_load_balancer" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_1a
  key_name               = var.key_pair
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "k8s-api-load-balancer"
  }
}


resource "aws_instance" "k8s_control_plane_1" {
  ami                    = var.ami
  instance_type          = "t2.medium"
  subnet_id              = var.subnet_1a
  key_name               = var.key_pair
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "k8s-control-plane-1"
  }
}

resource "aws_instance" "k8s_control_plane_2" {
  ami                    = var.ami
  instance_type          = "t2.medium"
  subnet_id              = var.subnet_1b
  key_name               = var.key_pair
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "k8s-control-plane-2"
  }
}

resource "aws_instance" "k8s_worker_1" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_1a
  key_name               = var.key_pair
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "k8s-worker-node-1"
  }
}

resource "aws_instance" "k8s_worker_2" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_1b
  key_name               = var.key_pair
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "k8s-worker-node-2"
  }
}