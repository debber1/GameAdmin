bool parseBool(String value) {
  if (value.toLowerCase() == 'true') {
    return true;
  } else if (value.toLowerCase() == 'false') {
    return false;
  }

  throw '"$value" can not be parsed to boolean.';
}
