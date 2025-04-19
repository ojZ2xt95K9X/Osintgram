SHELL := /bin/bash

setup:

	@echo -e "\e[34m####### Setup for Osintgram (Session ID Based) #######\e[0m"
	@[ -d config ] || mkdir config || exit 1
	@echo -n "{}" > config/settings.json
	@read -sp "Instagram Session ID: " sessionvar; \
	echo -en "[Credentials]\nsessionid = $$sessionvar" > config/credentials.ini || exit 1
	@echo ""
	@echo -e "\e[32mSetup Successful - config/credentials.ini created with session ID\e[0m"


run:

	@echo -e "\e[34m######## Building and Running Osintgram with Docker-compose ########\e[0m"
	@[ -d config ] || { echo -e "\e[31mConfig folder not found! Please run 'make setup' before running this command.\e[0m"; exit 1; }
	@echo -e "\e[34m[#] Killing old docker processes\e[0m"
	@docker-compose rm -fs || exit 1
	@echo -e "\e[34m[#] Building docker container\e[0m"
	@docker-compose build || exit 1
	@read -p "Target Username: " username; \
	docker-compose run --rm osintgram $$username

build-run-testing:

	@echo -e "\e[34m######## Building and Running Osintgram with Docker-compose for Testing/Debugging ########\e[0m"
	@[ -d config ] || { echo -e "\e[31mConfig folder not found! Please run 'make setup' before running this command.\e[0m"; exit 1; }
	@echo -e "\e[34m[#] Killing old docker processes\e[0m"
	@docker-compose rm -fs || exit 1
	@echo -e "\e[34m[#] Building docker container\e[0m"
	@docker-compose build || exit 1
	@echo -e "\e[34m[#] Running docker container in detached mode\e[0m"
	@docker-compose run --name osintgram-testing -d --rm --entrypoint "sleep infinity" osintgram || exit 1
	@echo -e "\e[32m[#] osintgram-test container is now Running!\e[0m"

cleanup-testing:
	@echo -e "\e[34m######## Cleanup Build-run-testing Container ########\e[0m"
	@docker-compose down
	@echo -e "\e[32m[#] osintgram-test container has been removed\e[0m"
