
class timeDistance{
  String _distance,_time;


  timeDistance(this._distance, this._time);

  factory timeDistance.fromJson(dynamic json) {
    return timeDistance(
      json["distance"]["text"],
      json["duration"]["text"],
    );
  }

  String get distance => _distance;

  get time => _time;
}