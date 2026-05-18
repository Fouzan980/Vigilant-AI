int fastHash(String string) {
  var hash = 0;
  for (var i = 0; i < string.length; i++) {
    hash = 0x1fffffff & (hash + string.codeUnitAt(i));
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    hash ^= hash >> 6;
  }
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash ^= hash >> 11;
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}
