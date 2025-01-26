output "k8s_api_load_balancer_private_ip" {
  value = aws_instance.k8s_api_load_balancer.private_ip
}

output "k8s_api_load_balancer_host_name" {
  value = aws_instance.k8s_api_load_balancer.private_dns
}
 
output "k8s_control_plane_1_private_ip" {
  value = aws_instance.k8s_control_plane_1.private_ip
}

output "k8s_control_plane_1_host_name" {
  value = aws_instance.k8s_control_plane_1.private_dns
}

output "k8s_control_plane_2_private_ip" {
  value = aws_instance.k8s_control_plane_2.private_ip
}

output "k8s_control_plane_2_host_name" {
  value = aws_instance.k8s_control_plane_2.private_dns
}

output "k8s_worker_1_private_ip" {
  value = aws_instance.k8s_worker_1.private_ip
}

output "k8s_worker_1_host_name" {
  value = aws_instance.k8s_worker_1.private_dns
}

output "k8s_worker_2_private_ip" {
  value = aws_instance.k8s_worker_2.private_ip
}

output "k8s_worker_2_host_name" {
  value = aws_instance.k8s_worker_2.private_dns
}