import 'package:flutter/material.dart';

class signupdata{
  int _vehicle_id,_model_id;
  String _name,_email,_phone,_type,_category,_weight,_code;

  signupdata(this._name, this._email, this._phone, this._type, this._category,
      this._weight,this._code,this._vehicle_id,this._model_id);

  get weight => _weight;

  get model_id => _model_id;

  get category => _category;

  get type => _type;

  get phone => _phone;

  get email => _email;

  get name => _name;

  get code => _code;

  int get vehicle_id => _vehicle_id;
}