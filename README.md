# Terraform-VPC-Module
Terraform module to create VPC on any region

### Archetecure that can be created using the module

![Capture2](https://user-images.githubusercontent.com/106676454/185465875-77460a72-163d-459e-b635-698ff881d5f7.png)




#### Variables to pass to the module
```sh
module "vpc" {

 source  = "Absolute path of the directory in which the module is present"
 cidr    = "cidr of the vpc you need to create"
 project = "Name of the project"
 env     = "Name of the environmet eq:- production,testing,development.."

}
```
#### Gathering output from the module

- output from the module
```sh
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public-1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public-2.id
} 

output "public_subnet_3_id" {
  value = aws_subnet.public-3.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private-1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private-2.id
}

output "private_subnet_3_id" {
  value = aws_subnet.private-3.id
}

```

- To call output from the VPC module
 
Example usage:-
  ```
  vpc_id      = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_1_id
  subnet_id = module.vpc.public_subnet_2_id
  subnet_id = module.vpc.public_subnet_3_id
  subnet_id = module.vpc.private_subnet_1_id
  subnet_id = module.vpc.private_subnet_2_id
  subnet_id = module.vpc.private_subnet_3_id
  ```
