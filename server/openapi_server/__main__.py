#!/usr/bin/env python3

import connexion

from openapi_server import encoder
import asyncpg
import asyncio


async def initdb():
    print("Initializing DB")
    url = "postgres://bikeracks:somethingclever@db:5432/bikeracks"
    db_connection = await asyncpg.create_pool(dsn=url)
    with open('schema.sql', 'r') as schema:
        for line in schema.read().split(';'):
            await db_connection.execute(line)


def main():
    asyncio.run(initdb())
    print("Database initialized!")
    app = connexion.App(__name__, specification_dir='./openapi/')
    app.app.json_encoder = encoder.JSONEncoder
    app.add_api('openapi.yaml',
                arguments={'title': 'BikeRacks'},
                pythonic_params=True)
    app.run(port=8080)


if __name__ == '__main__':
    main()
