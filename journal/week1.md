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








