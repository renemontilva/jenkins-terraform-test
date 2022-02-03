package terraform

import input as tfplan


# Allowed resources

allowed_resources = [
    "aws_subnet",
    "aws_instance",
    "aws_vpc"
]

array_contains(arr, elem) {
    arr[_] = elem
}

deny[reason] {
    resource := tfplan.resource_changes[_]
    
    not array_contains(allowed_resources, resource.type)

    reason := sprintf(
        "%s: resource type %q is not allowed",
        [resource.address, resource.type]
    )
}