
class vehicleModel{

  int _vehicle_id;
  String _vehicle,_loadcapacity,_vehicle_icon;

  vehicleModel(this._vehicle_id, this._vehicle, this._loadcapacity,this._vehicle_icon);

  factory vehicleModel.fromJson(dynamic json){
    return vehicleModel(
      json["vehicle_id"],
      json["vehicle"],
      json["loadcapacity"],
      json["vehicle_icon"],
    );
  }

  get loadcapacity => _loadcapacity;

  String get vehicle => _vehicle;

  int get vehicle_id => _vehicle_id;

  get vehicle_icon => _vehicle_icon;
}


class vehicleModel1{

  int _vehicle_id;
  String _vehicle,_loadcapacity,_vehicle_type;

  vehicleModel1(this._vehicle_id, this._vehicle, this._loadcapacity,this._vehicle_type);

  factory vehicleModel1.fromJson(dynamic json){
    return vehicleModel1(
      json["vehicle_id"],
      json["vehicle"],
      json["loadcapacity"],
      json["vehicle_type"],
    );
  }

  get loadcapacity => _loadcapacity;

  String get vehicle => _vehicle;

  int get vehicle_id => _vehicle_id;

  get vehicle_type => _vehicle_type;
}