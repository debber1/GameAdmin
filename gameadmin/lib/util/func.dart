import 'dart:math';

bool parseBool(String value) {
  if (value.toLowerCase() == 'true') {
    return true;
  } else if (value.toLowerCase() == 'false') {
    return false;
  }

  throw '"$value" can not be parsed to boolean.';
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';

String getRandomString(int length) {
  Random _rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
