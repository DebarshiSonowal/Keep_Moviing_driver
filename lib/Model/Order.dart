class Order {
  int _id;
  String _drop_location_name,
      _pickup_location_name,
      _payment_type,
      _order_id,
      _receiver_phone,
      _user_id,
      _user_name,
      _user_photo;
  var _drop_location_lat,
      _drop_location_lang,
      _pickup_location_lat,
      _pickup_location_lang,
      _total_price,
      _base_fare,
      _rate_per_km,
      _rate_per_minute,
      _waiting_charge,
      _total_distance;

  Order(
    this._id,
    this._drop_location_name,
    this._pickup_location_name,
    this._payment_type,
    this._order_id,
    this._receiver_phone,
    this._user_id,
    this._user_name,
    this._user_photo,
    this._drop_location_lat,
    this._drop_location_lang,
    this._pickup_location_lat,
    this._pickup_location_lang,
    this._base_fare,
    this._total_price,
    this._rate_per_km,
    this._rate_per_minute,
    this._waiting_charge,
    this._total_distance,
  );

  factory Order.fromJson(dynamic json) {
    return Order(
      json["id"],
      json["drop_location_name"],
      json["pickup_location_name"],
      json["payment_type"],
      json["order_id"],
      json["receiver_phone"],
      json["user_id"],
      json["user_name"],
      json["user_photo"],
      json["drop_location_lat"],
      json["drop_location_lang"],
      json["pickup_location_lat"],
      json["pickup_location_lang"],
      json["base_fare"],
      json["total_price"],
      json["rate_per_km"],
      json["rate_per_minute"],
      json["waiting_charge"],
      json["total_distance"],
    );
  }

  get total_distance => _total_distance;

  get waiting_charge => _waiting_charge;

  get rate_per_minute => _rate_per_minute;

  get rate_per_km => _rate_per_km;

  get total_price => _total_price;

  get base_fare => _base_fare;

  get pickup_location_lang => _pickup_location_lang;

  get pickup_location_lat => _pickup_location_lat;

  get drop_location_lang => _drop_location_lang;

  double get drop_location_lat => _drop_location_lat;

  get user_photo => _user_photo;

  get user_name => _user_name;

  get user_id => _user_id;

  get receiver_phone => _receiver_phone;

  get order_id => _order_id;

  get payment_type => _payment_type;

  get pickup_location_name => _pickup_location_name;

  String get drop_location_name => _drop_location_name;

  int get id => _id;
}
