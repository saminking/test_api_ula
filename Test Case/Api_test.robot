*** Settings ***
Resource        ../Resource/resource.robot

*** Test Cases ***
Get Single products
    GET Single products
    Validate Get single products Response Data type

Post New products
    POST products
    Validate Post product Response