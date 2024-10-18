class ApiUrl {
  static const String baseUrl =
      'http://responsi.webwizards.my.id/api/pariwisata';
  static const String registrasi =
      'http://responsi.webwizards.my.id/api/registrasi';
  static const String login = 'http://responsi.webwizards.my.id/api/login';
  static const String listFasilitas = baseUrl + '/fasilitas';
  static const String createFasilitas = baseUrl + '/fasilitas';
  static String updateFasilitas(int id) {
    return '$baseUrl/fasilitas/$id/update';
  }

  static String showFasilitas(int id) {
    return baseUrl + '/fasilitas/' + id.toString();
  }

  static String deleteFasilitas(int id) {
    return '$baseUrl/fasilitas/$id/delete';
  }
}
