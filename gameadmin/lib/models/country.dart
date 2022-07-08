class Country {
  String id;
  String code;
  String name;
  String flag;
  factory Country.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    if (id == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "id" is missing');
    }

    final code = data['code'] as String;
    if (code == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "code" is missing');
    }

    final name = data['name'] as String;
    if (name == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "name" is missing');
    }

    final flag = data['flag'] as String;
    if (flag == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "flag" is missing');
    }

    return Country(id, code, name, flag);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'flag': flag,
    };
  }

  Country(this.id, this.code, this.name, this.flag);
}
