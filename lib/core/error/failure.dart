/// A class representing a failure or error in the application.
class Failure {
  final String? message;
  Failure({this.message = 'An unexcepted error occured'});

  @override
  String toString() {
    return message ?? 'An unexcepted error occured';
  }

  factory Failure.noInternet() => Failure(message: 'İnternet bağlantısı yok');
  factory Failure.serverError() => Failure(message: 'Sunucu hatası');
  factory Failure.badResponse() => Failure(message: 'Geçersiz yanıt formatı');
  factory Failure.parseError(String error) =>
      Failure(message: 'Veri ayrıştırma hatası: $error');
  factory Failure.unknown(String error) =>
      Failure(message: 'Bilinmeyen hata: $error');

  factory Failure.fromStatusCode(int statusCode, String body) {
    String message;
    switch (statusCode) {
      case 400:
        message = 'Geçersiz istek';
        break;
      case 401:
        message = 'Yetkisiz erişim';
        break;
      case 403:
        message = 'Erişim engellendi';
        break;
      case 404:
        message = 'Kaynak bulunamadı';
        break;
      case 500:
        message = 'Sunucu hatası';
        break;
      default:
        message = 'Hata: $statusCode';
    }
    return Failure(message: message);
  }
}
