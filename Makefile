.PHONY: test

parallel:
	docker-compose up -d
	parallel --bar terragrunt --terragrunt-working-dir=provider/aws/{} --terragrunt-fetch-dependency-output-from-state --terragrunt-provider-cache --terragrunt-provider-cache-dir="$(PWD)/.cache/terragrunt/provider-cache" --terragrunt-non-interactive --terragrunt-include-external-dependencies --terragrunt-download-dir="$(PWD)/.cache/terragrunt/modules" plan -input=false -no-color -out={}.out ::: {1..50}

sequentially:
	docker-compose up -d
	parallel -j 1 --bar terragrunt --terragrunt-working-dir=provider/aws/{} --terragrunt-fetch-dependency-output-from-state --terragrunt-provider-cache --terragrunt-provider-cache-dir="$(PWD)/.cache/terragrunt/provider-cache" --terragrunt-non-interactive --terragrunt-include-external-dependencies --terragrunt-download-dir="$(PWD)/.cache/terragrunt/modules" plan -input=false -no-color -out={}.out ::: {1..50}

clean:
	docker-compose down
	rm -rf $(PWD)/.cache
	rm -rf $(PWD)/volume

