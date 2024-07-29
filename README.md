# Terraform Revirse Proxy

![Cloud Architecture](https://github.com/user-attachments/assets/6cfb53a7-4794-4871-b57b-171a71190846)

## Main keys 
1. Terraform modules
2. Terraform variables
3. Terraform Outputs
4. AWS Services (VPC - Subnets - EC2 - Loadbalancer)

__-__ __-__ __-__ __-__ __-__ __-__ __-__

### Requirments

1. AWS Account
2. Manage node
3. Install Terraform on manage node

__-__ __-__ __-__ __-__ __-__ __-__ __-__

### OverView

This Project utilized Terraform custom modules to modularize the infrastructure code. 
These modules encapsulated configurations for various components such as the VPC, subnets with dynamic scalability for both private and public environments, EC2 instances with dynamic scalability within subnets, and load balancers, making the infrastructure setup highly reusable and maintainable.

__-__ __-__ __-__ __-__ __-__ __-__ __-__

### Project Main Points

- Create VPC with 2 public subnets and 2 private subnets
- Create an EC2 for each subnet 
- Use user data to install Nginx server on Public EC2s and Apache server on Private EC2s
- Create a Security Group for nginx servers to allow the traffic from ports 22 , 80 from any outside ip
- Create a Security Group for Apache servers to allow the traffic from ports 22 , 80 only from the nginx servers
- Create a Loadbalancer with targetgroup for nginx servers and targetgroup for apache servers
- Create Loadbalancer listner 




