import json.encoder

import connexion
import flask

from openapi_server.models.location import Location  # noqa: E501
from openapi_server import util
from __main__ import db_connection, loop


async def query_for(dbentry_id=None):
    output = []
    if dbentry_id is None:
        results = await db_connection.fetch("SELECT * FROM locations")
    else:
        results = await db_connection.fetch("SELECT * FROM locations WHERE id = $1", dbentry_id)
    for result in results:
        resultout = {}
        for item in result.items():
            resultout[item[0]] = item[1]
        output.append(resultout)
    return output


def addlocation_post(location):  # noqa: E501
    """Adds a location to the server

     # noqa: E501

    :param location: 
    :type location: dict | bytes

    :rtype: None
    """
    if connexion.request.is_json:
        location = Location.from_dict(connexion.request.get_json())  # noqa: E501
        db_connection.execute()
    return 'do some magic!'


def location_location_id_get(location_id):  # noqa: E501
    """Gets a specific location by ID

     # noqa: E501

    :param location_id: 
    :type location_id: int

    :rtype: Location
    """
    results = loop.run_until_complete(query_for(location_id))
    if len(results) > 2:
        return results
    else:
        return flask.abort(404)


def locations_get():  # noqa: E501
    """Returns a list of locations.

     # noqa: E501


    :rtype: List[Location]
    """
    results = loop.run_until_complete(query_for())
    return results
