# openapi.api.DefaultApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://web.tweirtx.me/bikeracks/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addlocationPost**](DefaultApi.md#addlocationPost) | **POST** /addlocation | Adds a location to the server
[**locationLocationIdGet**](DefaultApi.md#locationLocationIdGet) | **GET** /location/{location_id} | Gets a specific location by ID
[**locationsGet**](DefaultApi.md#locationsGet) | **GET** /locations | Returns a list of locations.


# **addlocationPost**
> addlocationPost(location)

Adds a location to the server

### Example 
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final location = Location(); // Location | 

try { 
    api_instance.addlocationPost(location);
} catch (e) {
    print('Exception when calling DefaultApi->addlocationPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **location** | [**Location**](Location.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **locationLocationIdGet**
> Location locationLocationIdGet(locationId)

Gets a specific location by ID

### Example 
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final locationId = 56; // int | 

try { 
    final result = api_instance.locationLocationIdGet(locationId);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->locationLocationIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **locationId** | **int**|  | 

### Return type

[**Location**](Location.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **locationsGet**
> List<Location> locationsGet()

Returns a list of locations.

### Example 
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();

try { 
    final result = api_instance.locationsGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->locationsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<Location>**](Location.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

