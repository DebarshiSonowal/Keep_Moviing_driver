import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class turn {
  //html_instructions
  String _distance, _duration, _direction, _travel_mode, _maneuver;
  List<PointLatLng> _polyline_point;
  LatLng _end_location, _start_location;
  LatLngBounds _bounds;

  turn(
      this._distance,
      this._duration,
      this._direction,
      this._travel_mode,
      this._maneuver,
      this._bounds,
      this._polyline_point,
      this._end_location,
      this._start_location);

  factory turn.fromJson(dynamic json) {
    final data = json['legs'];
    return turn(
      data["distance"]["text"],
      data["duration"]["text"],
      data["html_instructions"],
      data["travel_mode"],
      data["maneuver"],
      LatLngBounds(
        northeast:
            LatLng(json["bounds"]["northeast"]['lat'], json["bounds"]['lng']),
        southwest:
            LatLng(json["bounds"]["southwest"]['lat'], json["bounds"]['lng']),
      ),
      data["polyline"]["points"],
      LatLng(
        double.parse(data["end_location"]["lat"].toString()),
        double.parse(data["end_location"]["lng"].toString()),
      ),
      LatLng(
        double.parse(json["start_location"]["lat"].toString()),
        double.parse(json["start_location"]["lng"].toString()),
      ),
    );
  }

  get start_location => _start_location;

  LatLng get end_location => _end_location;

  get polyline_point => _polyline_point;

  get maneuver => _maneuver;

  get travel_mode => _travel_mode;

  get direction => _direction;

  get duration => _duration;

  String get distance => _distance;
}
