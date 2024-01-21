#!/usr/bin/python3
import subprocess

def run_tf_command(path, backend_arg=None):
    try:
        command = ["terraform", "init", backend_arg] if backend_arg else ["terraform", "init"]
        subprocess.run(command, check=True, cwd=path)

        subprocess.run(["terraform", "fmt"], check=True, cwd=path)
        subprocess.run(["terraform", "validate"], check=True, cwd=path)
        subprocess.run(["terraform", "plan"], check=True, cwd=path)
        subprocess.run(["terraform", "apply", "-auto-approve"], check=True, cwd=path)

    except subprocess.SubprocessError as e:
        print(f"Error: {e}")


print("Setting up remote state in S3 and DynamoDB...")
run_tf_command("remote-state/")

# with backend configuration
print("\n==== Setting up static website in S3... ====\n")
msg = '''
*****************************************************************
\tManual operation Required
Don't forget to update the ns record of domain to the registered 
domain's nameserver after the hosted zone is created.\n
Otherwise, aws_acm_certificate_validation.cert: Creating... won't complete.
*****************************************************************\n
'''

print(msg)
run_tf_command("s3-website/", "-backend-config=backend.hcl")
