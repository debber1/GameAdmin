import '../util/func.dart';

class Division {
  String id;
  String name;
  bool shotClock;
  String shortName;
  factory Division.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    if (id == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "id" is missing');
    }

    final name = data['name'] as String;
    if (name == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "name" is missing');
    }

    final shotClock = data['shotClock'] as bool;
    if (shotClock == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "shotClock" is missing');
    }

    final shortName = data['shortName'] as String;
    if (shortName == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "shortName" is missing');
    }

    return Division(id, name, shotClock, shortName);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shotClock': shotClock,
      'shortName': shortName,
    };
  }

  Division(this.id, this.name, this.shotClock, this.shortName);
}
