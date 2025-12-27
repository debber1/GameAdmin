import 'dart:io';

class LegacyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // WARNING: Trusts all certificates!
        print("Allowing certificate for $host");
        return true;
      };
  }
}
