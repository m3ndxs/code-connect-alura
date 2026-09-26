class ApiUrl {
  ApiUrl._();

  static const String base = 'http://10.0.2.2:3000';

  static String resolve(String path) {
    if (path.isEmpty) return '';

    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    final normalizedBase = base.endsWith('/')
        ? base.substring(0, base.length - 1)
        : base;
    final suffix = path.startsWith('/') ? path : '/$path';

    return '$normalizedBase$suffix';
  }
}
