import 'package:gameadmin/util/func.dart';

class Pitch {
  String id;
  String name;
  bool shotClock;
  bool finalePitch;
  String? pitchResponsable;
  factory Pitch.fromJson(Map<String, dynamic> data) {
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

    final shotClock = parseBool(data['shotClock']) as bool;
    if (shotClock == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "shotClock" is missing');
    }

    final finalePitch = parseBool(data['finalePitch']) as bool;
    if (finalePitch == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "finalePitch" is missing');
    }

    final pitchResponsable = data['pitchResponsable'] as String;
    if (pitchResponsable == null) {
      // Data vallidation
      throw UnsupportedError(
          'Invalid data: $data -> "pitchResponsable" is missing');
    }

    return Pitch(id, name, shotClock, finalePitch, pitchResponsable);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shotClock': shotClock,
      'finalePitch': finalePitch,
      'pitchResponsable': pitchResponsable,
    };
  }

  Pitch(this.id, this.name, this.shotClock, this.finalePitch,
      this.pitchResponsable);
}
