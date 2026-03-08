
rebuild: | clean migrations container-down

container-up:
	docker compose -f ./local-ctl/compose.yaml up -d
	sleep 1

container-down:
	docker compose -f ./local-ctl/compose.yaml down
	sleep 1

ui-up:
	docker compose -f ./local-ctl/ui.compose.yaml up -d
	sleep 1

ui-down:
	docker compose -f ./local-ctl/ui.compose.yaml down
	sleep 1
	
migrations: container-up
	alembic -x add-triggers=0 revision --autogenerate -m "initial"
	alembic upgrade head
	alembic -x add-triggers=1 revision --autogenerate -m "triggers"
	alembic upgrade head --sql > ./migrations/versions/migrations.sql

clean:
	rm -rf ./migrations/versions/*
