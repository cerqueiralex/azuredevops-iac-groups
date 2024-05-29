# Stack to Control the Environment Groups and Access

This stack creates azure devops teams, add users to these teams, and also create Azure Devops Pipeline environments with those groups (and optionally other emails) as approvers. 

## How to create new groups and environments

### Terraform.tfvars standard for parameters
This is the standard of the parameters we need to pass on the terraform.tfvars based on this azure-groups-management.yaml that is being used on /subscriptions/bees-cloud/instances/azure-groups-management/azure-groups-management.yaml


```
stack:
  name: azure-groups-management
  version: 0.1.1
  tfvarsConfig: |
    groups = {
      "group_name" : ["your@email.com", "your@email.com"],
      "group_name" : ["your@email.com", "your@email.com"],
    }
    environments = {
      environment_name: [
        { resource : "resource_type_name", name : "resource_name", groups : ["group_name"], emails : [] },
        { resource : "resource_type_name", name : "resource_name", groups : ["group_name"], emails : [] },
        { resource : "resource_type_name", name : "resource_name", groups : ["group_name"], emails : [] },
      ]
    }
```
### The groups variable 

Is a map of strings to list of strings. The keys decide the group names, and the values are a list of emails (az devops users) who should be added to these groups.

The name of the group must follow a standard corresponding to the name of the Business Structure.

### The environments variable 

Is a map of strings to list of resources. The key of the map are the teams of the company.

The resource list is a list of objects with the following format:

- resource: string 
- name: string 
- groups: list(string).
- emails: list(string) 

> The email should only be added in case of an exception because the groups should already have the correct engineers for approval.

### The resource 

Is a string referencing the resource like Cosmosdb, Postgres, CloudAMQP, etc.

The name is just a string used as a part of the environment name.

The groups is a list of groups referencing the first attribute, implying the groups who have permission to approve the environment.

The environment end result name in this project example follows this format: <resource>-approvers-<name>

### Creating new groups and environments:

This is the TFVars for the instance that is built during the Pull Request Validation.

Put here the configurations that you want to consider on this instance.

```
groups = {
  "bees-resources" : ["your@email.com"],
}
environments = {
  environment_name : [
    { resource : "ci", name : "test", groups : ["azure-groups-management-stack-ci"], emails : ["your@email.com"] },
  ],
}
```

## Groups Module

This code creates an Azure DevOps group with members specified in an email list (var.emails), retrieves their descriptors (unique identifiers), and outputs the group's origin ID.

This Terraform module is designed to manage Azure DevOps groups and group memberships. It creates a group within a specified Azure DevOps project and assigns users to this group based on their email addresses.

### Files and Their Purposes

- main.tf: Contains the primary resources for creating the Azure DevOps group and managing its membership.
- locals.tf: Defines local values used within the configuration, particularly for extracting user descriptors.
- outputs.tf: Specifies the outputs of the Terraform stack, which in this case is the origin ID of the created Azure DevOps group.
- providers.tf: Specifies the providers required for the Terraform stack.
- variables.tf: This file declares input variables for the Terraform configuration.

## Environments module
This Terraform module automates the creation of Azure DevOps environments with approval workflows in the "Company Project Name" project. It enables developers to define environments through variables.

<img src="https://learn.microsoft.com/pt-br/azure/deployment-environments/media/overview-what-is-azure-deployment-environments/azure-deployment-environments-scenarios.png" />
imagem: https://learn.microsoft.com/pt-br/azure/deployment-environments/overview-what-is-azure-deployment-environments

### Files and Their Purposes
- main.tf: This file configures Azure DevOps resources. It fetches the project details and user information based on their email addresses.
- locals.tf: This file defines local variables and maps to streamline and manage the environment configurations efficiently. It processes and organizes the input data, such as environment details and email lists, into structured formats that are easier to reference in other parts of the configuration.
- variables.tf: This file declares input variables for the Terraform configuration.
- providers.tf: This file specifies the providers required by Terraform to interact with Azure, Azure DevOps, and to generate random data.
