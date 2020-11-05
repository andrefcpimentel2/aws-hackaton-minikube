

output "hackathon_ip" {
  value       = aws_instance.minikube.public_ip
}