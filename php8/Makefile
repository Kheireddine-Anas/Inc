name = Inception

all:
	@bash /home/akheired/kira/srcs/requirements/wordpress/tools/check_dir.sh
	@printf "Running configuration ${name}... 🚀\n"
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

down:
	@printf "Stopping configuration ${name}... 🚫\n"
	@docker-compose -f ./srcs/docker-compose.yml down

clean: down
	@printf "Cleaning configuration ${name}...  🧹\n"
	@docker rm -f $$(docker ps -qa) 2>/dev/null || true
	@docker rmi -f $$(docker images -q) 2>/dev/null || true

fclean:
	@printf "Complete clearing of all docker configurations... 🧹\n"
	@docker system prune -a --force
	@docker stop $$(docker ps -q) 2>/dev/null || true
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force

show:
	@printf "Showing configuration ${name}... 🗂\n"
	@docker-compose -f ./srcs/docker-compose.yml ps

showall:
	@printf "Showing configuration ${name}...  🗂🗂\n"
	@docker-compose -f ./srcs/docker-compose.yml ps -a

showimg:
	@printf "Showing images... 📸\n"
	@docker images

rmi:
	@printf "Removing images...  🧹\n"
	@docker rmi -f $$(docker images -q) 2>/dev/null || true

re: fclean all
