init:
	terraform init
create-workspace-smart-garage:
	terraform workspace new smart-garage
get-smart-garage:
	terraform workspace select smart-garage
	terraform get
plan-smart-garage: get-smart-garage
	terraform plan 
apply-smart-garage: get-smart-garage
	terraform apply
