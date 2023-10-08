# Terraform Beginner Bootcamp 2023 - Week  1

## Root Module Structure
Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

We can use the `-var-file` flag to specify a variable file when running `terraform apply` or `terraform plan`. 

This allows us to define variables in a separate file and then reference that file when we run Terraform commands. 

This can be useful for managing and sharing configuration options without modifying the main Terraform configuration file.
Example:
```sh
terraform apply -var-file=variables.tfvars
```

### terraform.tvfars

This is the default file to load in terraform variables in blunk.

### auto.tfvars

The `auto.tfvars` file is a special filename that Terraform automatically loads as a variable file without the need to specify it using the `-var-file` flag. 

When Terraform runs, it will automatically look for and load variable values from a file named auto.tfvars in the same directory as your Terraform configuration files.

We can use auto.tfvars to define default values for our variables, and these values will be applied unless overridden by values from other variable files or explicit command-line variable definitions.

### Order of Terraform Variables

Variables can be set and overridden in several ways, and they follow a specific order of precedence. Here's the order in which variables take precedence:

- **Environment Variables**: The highest precedence is given to variables set via environment variables. We can set variables by prefixing them with TF_VAR_ and then specifying the variable name in uppercase. For example,
```sh
TF_VAR_region=us-west-2
```
- **Command-Line Flags**: Variables specified directly on the command line take precedence over environment variables. We can use the -var flag to set a variable when running Terraform commands. For example,
```sh
terraform apply -var="region=us-west-1"
```
- **Variable Files**: Variable files specified with the -var-file flag. These files can define default values for variables. When used, these values will override any previous variable values. For example,
```sh
terraform apply -var-file=variables.tfvars
```
- **Default Values**: If no value is provided by any of the above methods, the default value specified in the variable definition within the Terraform configuration takes effect.
- **No Value**: If a variable is not set using any of the methods above and has no default value specified, Terraform will prompt the user for a value when running the apply or plan command. This is an interactive method, and it should be avoided in automated or non-interactive workflows.

## Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommend to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older examples that could be deprecated. Often affecting providers.

## Working with Files in Terraform


### Fileexists function

This is a built in terraform function to check the existance of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

## Terraform Locals

Locals allows us to define local variables.
It can be very useful when we need transform data into another format and have referenced a varaible.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

This allows use to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)





