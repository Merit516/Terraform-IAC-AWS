#                  Terraform-(CloudProxy-IaC)-AWS 

CloudProxy is a cloud security company that offers cloud security services for AWS Platform. CloudProxy provides a range of security services, such as intrusion detection and prevention, vulnerability scanning, and web application firewall, among others. It also offers Infrastructure-as-Code (IaC) services that allow users to define and manage their cloud infrastructure resources using code.
CloudProxy  is used in the context of cloud infrastructure, this  serve different purposes. CloudProxy is focused on security services and IaC.
CloudProxy-IaC allows users to define their cloud infrastructure in a declarative language, such as Terraform, and apply changes to their infrastructure in a controlled and repeatable manner. With CloudProxy-IaC, users can define their infrastructure as code, version control it, and apply changes to it in a consistent way.
![cloud-proxy-aws-terraform](https://github.com/Merit516/Terraform-IAC-AWS/assets/58358691/4c96a7ef-df7f-425d-9396-013e3a1bbf4d)
# Prerequisites
1-You need an already deployed VPC, with public and private subnets spreading at leat over two Availability Zones (AZs). You can find a description of how to set up your VPC environment at Default VPC Setup.

2-You must have an internet gateway, with routing set up so that only traffic from a public subnet can reach the internet.

3-It set up a Vritual private cloud(VPC) with Internet Gatway, public and private subnets , an Application load balancer(ALB) and EC2 instances, The archeitecture enavle routing requests from am internet-facing ALP to Nginx reverse a proxy instances to in internal ALB , The internal ALB directs the tarffic to Apache web server instance instances in private subnets ,serving the website content.

4-The  remote backend block in Terraform configuration files is used to configure where Terraform stores its state file, which is a record of the current state of the infrastructure being managed. The state file is important because it helps Terraform to understand the current state of the infrastructure and what changes need to be made to bring it to the desired state.

- Using a remote backend like S3 allows multiple Terraform users to collaborate on infrastructure changes and ensures that the state file is always stored in a reliable, centralized location. It also provides additional security and auditing capabilities, such as versioning, logging, and access controls.

# Note 
You must have your own yourkey.pem in project working directory.

# to use 
*  To Install AWS CLI

<pre><code class="copy-button">
 sudo apt install awscli -y 
</code></pre>


* Configure Your Credientials [ID,Access-Key,regoin,profile]

<pre><code class="copy-button">
 aws configure
</code></pre>

*  To Install Terrform

<pre><code class="copy-button">
 https://phoenixnap.com/kb/how-to-install-terraform
</code></pre> 


* To Clone this Repository 
<pre><code class="copy-button">
 git clone 
</code></pre>

* To Run 
<pre><code class="copy-button">
 terraform workspace new dev
</code></pre>  

* To Initialize
<pre><code class="copy-button">
 terraform init
</code></pre> 

* To Test
<pre><code class="copy-button">
 terraform init
</code></pre>  

* To Apply
<pre><code class="copy-button">
 terraform apply
</code></pre> 

-write < yes > to create  resources

* The DNS of Public Loadbalancer printes  in public-loadbalancer-dns.txt  copy it and test in your browser
<pre><code class="copy-button">
  cat public-loadbalancer.txt
</code></pre>   

* To Destroy all Resources
<pre><code class="copy-button">
  terraform destroy
</code></pre>   




