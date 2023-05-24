#                  Terraform-(CloudProxy-IaC)-AWS 

CloudProxy is a cloud security company that offers cloud security services for AWS Platform. CloudProxy provides a range of security services, such as intrusion detection and prevention, vulnerability scanning, and web application firewall, among others. It also offers Infrastructure-as-Code (IaC) services that allow users to define and manage their cloud infrastructure resources using code.
CloudProxy  is used in the context of cloud infrastructure, this  serve different purposes. CloudProxy is focused on security services and IaC.
CloudProxy-IaC allows users to define their cloud infrastructure in a declarative language, such as Terraform, and apply changes to their infrastructure in a controlled and repeatable manner. With CloudProxy-IaC, users can define their infrastructure as code, version control it, and apply changes to it in a consistent way.
# Prerequisites
1-You need an already deployed VPC, with public and private subnets spreading at leat over two Availability Zones (AZs). You can find a description of how to set up your VPC environment at Default VPC Setup.

2-You must have an internet gateway, with routing set up so that only traffic from a public subnet can reach the internet.
![cloud-proxy-aws-terraform](https://github.com/Merit516/Terraform-IAC-AWS/assets/58358691/4c96a7ef-df7f-425d-9396-013e3a1bbf4d)
It set up a Vritual private cloud(VPC) with Internet Gatway,
