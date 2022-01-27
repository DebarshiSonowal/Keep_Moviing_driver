class profile {
  int _id, _vehicle_id, _min_rate, _max_rate,_driver_rate,_user_id;
  var _profile_img;

  String _name,
      _email,
      _phone,
      _city,
      _company,
      _vehicle_type,
      _load_capacity,
      _truck_owner_name,
      _registration_certificate,
      _insurance,
      _PUC_certificate,
      _fitness,
      _permit,
      _driving_license,
      _status,
      _GST,
      _pickup_address,
      _dropoff_address;

  profile(
      this._id,
      this._name,
      this._email,
      this._phone,
      this._city,
      this._company,
      this._vehicle_id,
      this._vehicle_type,
      this._load_capacity,
      this._user_id,
      this._truck_owner_name,
      this._registration_certificate,
      this._insurance,
      this._PUC_certificate,
      this._fitness,
      this._permit,
      this._driving_license,
      this._status,
      this._GST,
      this._min_rate,
      this._max_rate,
      this._driver_rate,
      this._pickup_address,
      this._dropoff_address,
      this._profile_img,);

  factory profile.fromJson(dynamic json) {
    return profile(
      json['id'],
      json['name'],
      json['email'],
      json['phone'],
      json['city'],
      json['company'],
      json['vehicle_id'],
      json['vehicle_type'],
      json['load_capacity'],
      json['user_id'],
      json['truck_owner_name'],
      json['registration_certificate'],
      json['insurance'],
      json['PUC_certificate'],
      json['fitness'],
      json['permit'],
      json['driving_license'],
      json['status'],
      json['GST'],
      json['min_rate'],
      json['max_rate'],
      json['driver_rate'],
      json['pickup_address'],
      json['dropoff_address'],
      json['profile_img'],
    );
  }

  set set_driver_rate(value) {
    _driver_rate = value;
  }

  get dropoff_address => _dropoff_address;

  get pickup_address => _pickup_address;

  get status => _status;

  get driving_license => _driving_license;

  get permit => _permit;

  get fitness => _fitness;

  get PUC_certificate => _PUC_certificate;

  get insurance => _insurance;

  get registration_certificate => _registration_certificate;

  get truck_owner_name => _truck_owner_name;

  get user_id => _user_id;

  get driver_rate => _driver_rate;

  get load_capacity => _load_capacity;

  get vehicle_type => _vehicle_type;

  get vehicle_id => _vehicle_id;

  get company => _company;

  get city => _city;

  get phone => _phone;

  get email => _email;

  get GST => _GST;

  String get name => _name;

  int get id => _id;

  get max_rate => _max_rate;

  get min_rate => _min_rate;

  set set_city(value) {
    _city = value;
  }

  get profile_img => _profile_img;
}
