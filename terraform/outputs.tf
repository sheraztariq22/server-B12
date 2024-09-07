output "server_public_ip" {
  description = "The public IP address of the server instance."
  value       = aws_instance.server.public_ip
}
