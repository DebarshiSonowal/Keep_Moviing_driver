

class chatModel{
  String _message,_time,_senderId;

  chatModel(this._message, this._time, this._senderId);

  factory chatModel.fromJson(dynamic json) {
    return chatModel(
      json["message"],
      json["time"],
      json["sender"],
    );
  }

  get senderId => _senderId;

  get time => _time;

  String get message => _message;
}