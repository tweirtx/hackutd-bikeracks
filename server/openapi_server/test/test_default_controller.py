# coding: utf-8

from __future__ import absolute_import
import unittest

from flask import json
from six import BytesIO

from openapi_server.models.location import Location  # noqa: E501
from openapi_server.test import BaseTestCase


class TestDefaultController(BaseTestCase):
    """DefaultController integration test stubs"""

    def test_addlocation_post(self):
        """Test case for addlocation_post

        Adds a location to the server
        """
        location = {
  "latitude" : 6.027456183070403,
  "description" : "description",
  "photo" : "photo",
  "id" : 0,
  "longitude" : 32.59
}
        headers = { 
            'Content-Type': 'application/json',
        }
        response = self.client.open(
            '/bikeracks/v1/addlocation',
            method='POST',
            headers=headers,
            data=json.dumps(location),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_location_location_id_get(self):
        """Test case for location_location_id_get

        Gets a specific location by ID
        """
        headers = { 
            'Accept': 'application/json',
        }
        response = self.client.open(
            '/bikeracks/v1/location/{location_id}'.format(location_id=56),
            method='GET',
            headers=headers)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_locations_get(self):
        """Test case for locations_get

        Returns a list of locations.
        """
        headers = { 
            'Accept': 'application/json',
        }
        response = self.client.open(
            '/bikeracks/v1/locations',
            method='GET',
            headers=headers)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    unittest.main()
