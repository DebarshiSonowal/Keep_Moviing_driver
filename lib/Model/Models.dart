class Model {
  int _model_id;
  String _model_name;
  var _loadcapacity;

  Model(this._model_id, this._model_name, this._loadcapacity);

  factory Model.fromJson(dynamic json) {
    return Model(
      json["model_id"],
      json["model_name"],
      json["loadcapacity"],
    );
  }

  get loadcapacity => _loadcapacity;

  String get model_name => _model_name;

  int get model_id => _model_id;
}
