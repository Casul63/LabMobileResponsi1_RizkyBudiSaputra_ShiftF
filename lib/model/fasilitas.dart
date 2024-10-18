class Fasilitas {
  int? id;
  String? facility;
  String? type;
  String? facilityStatus;
  Fasilitas({this.id, this.facility, this.type, this.facilityStatus});
  factory Fasilitas.fromJson(Map<String, dynamic> obj) {
    return Fasilitas(
        id: obj['id'],
        facility: obj['facility'],
        type: obj['type'],
        facilityStatus: obj['status']);
  }
}
