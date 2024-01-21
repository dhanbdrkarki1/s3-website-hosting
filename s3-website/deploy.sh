#!/bin/bash
 terraform init -backend-config=backend.hcl
 terraform fmt && terraform validate
 terraform plan
 terraform apply -auto-approve