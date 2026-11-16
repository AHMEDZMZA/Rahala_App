// class ApiEndpoints {
//   ApiEndpoints._();
//
//   static String getImageUrl(String? path) {
//     if (path == null || path.isEmpty) return '';
//     if (path.startsWith('http://') || path.startsWith('https://')) {
//       return path;
//     }
//     return '$baseDomain$path';
//   }
//
//   static const String baseUrl = 'https://rahala.duckdns.org/api/v1';
//   static const String login = '/auth/login';
//   static const String googleLogin = '/auth/google';
//   static const String register = '/auth/register';
//   static const String refreshToken = '/auth/refresh-token';
//   static const String profile = '/user/profile';
//   static const String categories = '/categories';
//
//   /// admin
//   static const String adminStats = '/admin/stats';
//   static const String adminTrips = '/trips/admin/all';
//   static const String trips = '/trips';
//
//   // booking
//   static const String booking = '/bookings';
//
//   // offers
//   static const String offers = '/offers';
//
//   //favorite
//   static const String favorites = '/favorites';
// }


class ApiEndpoints {
  ApiEndpoints._();

  /// الدومين الأساسي (مصدر واحد للقيمة)
  /// للتغيير وقت التشغيل:
  /// flutter run --dart-define=BASE_DOMAIN=https://rahala.duckdns.org
  static const String baseDomain = String.fromEnvironment(
    'BASE_DOMAIN',
    defaultValue: 'https://rahala.duckdns.org',
  );

  /// يُشتق تلقائيًا من baseDomain
  static const String baseUrl = '$baseDomain/api/v1';

  static String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    // نضمن وجود "/" واحدة بين الدومين والمسار
    final cleanPath = path.startsWith('/') ? path : '/$path';
    return '$baseDomain$cleanPath';
  }

  // auth
  static const String login = '/auth/login';
  static const String googleLogin = '/auth/google';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh-token';

  // user
  static const String profile = '/user/profile';
  static const String categories = '/categories';

  /// admin
  static const String adminStats = '/admin/stats';
  static const String adminTrips = '/trips/admin/all';
  static const String trips = '/trips';

  // booking
  static const String booking = '/bookings';

  // offers
  static const String offers = '/offers';

  // favorites
  static const String favorites = '/favorites';
}
