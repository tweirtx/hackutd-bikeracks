//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Location {
  /// Returns a new [Location] instance.
  Location({
    this.id=null,
    this.latitude,
    this.longitude,
    this.description,
    this.photo,
  });

  int id;

  num latitude;

  num longitude;

  String description;

  String photo;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Location &&
     other.id == id &&
     other.latitude == latitude &&
     other.longitude == longitude &&
     other.description == description &&
     other.photo == photo;

  @override
  int get hashCode =>
    (id == null ? 0 : id.hashCode) +
    (latitude == null ? 0 : latitude.hashCode) +
    (longitude == null ? 0 : longitude.hashCode) +
    (description == null ? 0 : description.hashCode) +
    (photo == null ? 0 : photo.hashCode);

  @override
  String toString() => 'Location[id=$id, latitude=$latitude, longitude=$longitude, description=$description, photo=$photo]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (id != null) {
      json[r'id'] = id;
    }
    if (latitude != null) {
      json[r'latitude'] = latitude;
    }
    if (longitude != null) {
      json[r'longitude'] = longitude;
    }
    if (description != null) {
      json[r'description'] = description;
    }
    if (photo != null) {
      json[r'photo'] = photo;
    }
    return json;
  }

  /// Returns a new [Location] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static Location fromJson(Map<String, dynamic> json) => json == null
    ? null
    : Location(
        id: json[r'id'],
        latitude: json[r'latitude'] == null ?
          null :
          json[r'latitude'].toDouble(),
        longitude: json[r'longitude'] == null ?
          null :
          json[r'longitude'].toDouble(),
        description: json[r'description'],
        photo: json[r'photo'],
    );

  static List<Location> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <Location>[]
      : json.map((v) => Location.fromJson(v)).toList(growable: true == growable);

  static Map<String, Location> mapFromJson(Map<String, dynamic> json) {
    final map = <String, Location>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) => map[key] = Location.fromJson(v));
    }
    return map;
  }

  // maps a json object with a list of Location-objects as value to a dart map
  static Map<String, List<Location>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<Location>>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) {
        map[key] = Location.listFromJson(v, emptyIsNull: emptyIsNull, growable: growable);
      });
    }
    return map;
  }
}

