build:
	@docker build --tag=ros2:devel			devel/.
	@docker build --tag=ros2:source			source/.
	@docker build --tag=ros2:ros1_bridge ros1_bridge/.

run:
	@docker run -it ros2:ros1_bridge /bin/bash
