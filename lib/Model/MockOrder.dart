

class mockOrder{
  String _name,_pickup,_drop;
  double _amount,_distance;
  List<String> _paymentMethods;

  mockOrder(this._name, this._pickup, this._drop, this._amount, this._distance,
      this._paymentMethods);

  List<String> get paymentMethods => _paymentMethods;

  get distance => _distance;

  double get amount => _amount;

  get drop => _drop;

  get pickup => _pickup;

  String get name => _name;
}