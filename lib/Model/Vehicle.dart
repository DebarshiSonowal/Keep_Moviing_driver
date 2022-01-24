
class vehicleModel{

  int _vehicle_id;
  String _vehicle,_loadcapacity;

  vehicleModel(this._vehicle_id, this._vehicle, this._loadcapacity);

  factory vehicleModel.fromJson(dynamic json){
    return vehicleModel(
      json["vehicle_id"],
      json["vehicle"],
      json["loadcapacity"],
    );
  }

  get loadcapacity => _loadcapacity;

  String get vehicle => _vehicle;

  int get vehicle_id => _vehicle_id;
}