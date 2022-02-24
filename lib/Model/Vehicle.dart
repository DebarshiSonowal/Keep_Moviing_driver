import 'dart:core';

import 'package:my_cab_driver/Model/Models.dart';

class vehicleModel {
  int _vehicle_id;
  String _vehicle, _loadcapacity, _vehicle_icon;
  List<Model> _models;

  vehicleModel(this._vehicle_id, this._vehicle, this._loadcapacity,
      this._vehicle_icon, this._models);

  factory vehicleModel.fromJson(dynamic json) {
    return vehicleModel(
      json["vehicle_id"],
      json["vehicle"],
      json["loadcapacity"],
      json["vehicle_icon"],
      (json["model"] as List).map((e) => Model.fromJson(e)).toList(),
    );
  }

  List<Model> get models => _models;

  get loadcapacity => _loadcapacity;

  String get vehicle => _vehicle;

  int get vehicle_id => _vehicle_id;

  get vehicle_icon => _vehicle_icon;
}

class vehicleModel1 {
  int _vehicle_id,_model_id;
  String _vehicle, _loadcapacity, _vehicle_type;

  vehicleModel1(
      this._vehicle_id, this._vehicle, this._loadcapacity, this._vehicle_type,this._model_id);

  factory vehicleModel1.fromJson(dynamic json) {
    return vehicleModel1(
      json["vehicle_id"],
      json["vehicle"],
      json["loadcapacity"],
      json["vehicle_type"],
      json["model_id"],
    );
  }

  get model_id => _model_id;

  get loadcapacity => _loadcapacity;

  String get vehicle => _vehicle;

  int get vehicle_id => _vehicle_id;

  get vehicle_type => _vehicle_type;
}
