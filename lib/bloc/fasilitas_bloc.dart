import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/fasilitas.dart';

class FasilitasBloc {
  static Future<List<Fasilitas>> getFasilitas() async {
    String apiUrl = ApiUrl.listFasilitas;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listFasilitas = (jsonObj as Map<String, dynamic>)['data'];
    List<Fasilitas> fasilitases = [];
    for (int i = 0; i < listFasilitas.length; i++) {
      fasilitases.add(Fasilitas.fromJson(listFasilitas[i]));
    }
    return fasilitases;
  }

  static Future addFasilitas({Fasilitas? fasilitas}) async {
    String apiUrl = ApiUrl.createFasilitas;
    var body = {
      "facility": fasilitas!.facility,
      "type": fasilitas.type,
      "status": fasilitas.facilityStatus
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateFasilitas({required Fasilitas fasilitas}) async {
    String apiUrl = ApiUrl.updateFasilitas(fasilitas!.id!);
    print(apiUrl);
    var body = {
      "facility": fasilitas.facility,
      "type": fasilitas.type,
      "status": fasilitas.facilityStatus
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteFasilitas({int? id}) async {
    String apiUrl = ApiUrl.deleteFasilitas(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
