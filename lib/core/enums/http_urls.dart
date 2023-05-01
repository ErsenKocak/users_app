enum HttpClientApiUrl { users, userImage }

extension HttpClientApiUrlExtension on HttpClientApiUrl {
  String get uri {
    switch (this) {
      case HttpClientApiUrl.users:
        return 'users';
      case HttpClientApiUrl.userImage:
        return '/info';

      default:
        return '';
    }
  }
}
