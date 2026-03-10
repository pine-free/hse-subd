from sqlalchemy import URL
import logging
from typing import Generator

import pytest
from testcontainers.postgres import DbContainer, PostgresContainer

logger = logging.getLogger(__name__)


@pytest.fixture(scope="package")
def postgres_url(request: pytest.FixtureRequest) -> Generator[URL]:
    containers: list[DbContainer] = []

    db_credentials: dict[str, str | int] = {
        "driver": "postgresql+psycopg",
        "hostname": "localhost",
        "port": 5432,
        "username": "postgres",
        "password": "postgres",
        "dbname": "postgres",
    }
    base_dir = request.config.rootpath

    postgres = (
        PostgresContainer("r-docker.repository.avp.ru/postgres:16", **db_credentials)
        .with_bind_ports(db_credentials["port"], 5432)
        .with_command("postgres -c log_statement=all")
        .with_volume_mapping(
            base_dir / "local-ctl/lib/postgres/01-apply-migrations.sh",
            "/docker-entrypoint-initdb.d/01-apply-migrations.sh",
        )
        .with_volume_mapping(
            base_dir / "migrations/versions", "/docker-entrypoint-initdb.d/migrations"
        )
        .start()
    )

    containers.append(postgres)

    db_credentials["port"] = postgres.get_exposed_port(5432)

    logger.info(
        f"Started Postgres: {postgres._container.name}, {postgres._container.short_id}, {db_credentials}"
    )
    url = URL.create(
        drivername=str(db_credentials["driver"]),
        username=str(db_credentials["username"]),
        password=str(db_credentials["password"]),
        host=str(db_credentials["hostname"]),
        port=int(db_credentials["port"]),
    )

    yield url

    try:
        for c in containers:
            c.stop(delete_volume=True)
    except Exception:
        # If we can't stop the container
        # we just give up (it's probably stopped already)
        logger.warning(
            "cannot stop postgres container on teardown. it's likely stopped already"
        )
