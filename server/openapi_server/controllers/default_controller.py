import connexion
import six

from openapi_server.models.location import Location  # noqa: E501
from openapi_server import util


def addlocation_post(location):  # noqa: E501
    """Adds a location to the server

     # noqa: E501

    :param location: 
    :type location: dict | bytes

    :rtype: None
    """
    if connexion.request.is_json:
        location = Location.from_dict(connexion.request.get_json())  # noqa: E501
    return 'do some magic!'


def location_location_id_get(location_id):  # noqa: E501
    """Gets a specific location by ID

     # noqa: E501

    :param location_id: 
    :type location_id: int

    :rtype: Location
    """
    return 'do some magic!'


def locations_get():  # noqa: E501
    """Returns a list of locations.

     # noqa: E501


    :rtype: List[Location]
    """
    return 'do some magic!'
