#!/usr/bin/env python3

import connexion

from openapi_server import encoder
import asyncpg
import asyncio

global db_connection, loop


async def initdb():
    url = "postgres://bikeracks:somethingclever@db:5432/bikeracks"
    global db_connection
    db_connection = await asyncpg.create_pool(dsn=url)
    with open('schema.sql', 'r') as schema:
        file_contents = schema.read()
        schema_lines = file_contents.split(';')
        for line in schema_lines:
            if len(line) != 1:
                print(len(line))
                await db_connection.execute(line)


def main():
    global loop
    loop = asyncio.get_event_loop()
    loop.run_until_complete(initdb())
    app = connexion.App(__name__, specification_dir='./openapi/')
    app.app.json_encoder = encoder.JSONEncoder
    app.add_api('openapi.yaml',
                arguments={'title': 'BikeRacks'},
                pythonic_params=True)
    app.run(port=8080)


if __name__ == '__main__':
    main()
