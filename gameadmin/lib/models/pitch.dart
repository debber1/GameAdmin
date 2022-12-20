import 'package:gameadmin/util/func.dart';

class Pitch {
  String id;
  String name;
  bool shotClock;
  bool finalePitch;
  String? pitchResponsable;
  String? scoreIP;
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
    final scoreIP = data['scoreIP'] as String;
    if (pitchResponsable == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "scoreIP" is missing');
    }

    return Pitch(id, name, shotClock, finalePitch, pitchResponsable, scoreIP);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shotClock': shotClock.toString(),
      'finalePitch': finalePitch.toString(),
      'pitchResponsable': pitchResponsable,
      'scoreIP': scoreIP,
    };
  }

  Pitch(this.id, this.name, this.shotClock, this.finalePitch,
      this.pitchResponsable, this.scoreIP);
}
