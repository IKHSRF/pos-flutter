import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _merek = _firestore.collection('merek');
  static CollectionReference _distributor =
      _firestore.collection('distributor');

  //Add section
  static Future<String> tambahMerek(String merek) async {
    try {
      DocumentReference result = await _merek.add(<String, dynamic>{
        'nama_merek': merek,
      });
      print(result.toString());
      return 'berhasil';
    } catch (error) {
      print(error.message);
      return error.message;
    }
  }

  static Future<String> tambahDistributor(
      String nama, String noTelp, String alamat) async {
    try {
      DocumentReference result = await _distributor.add(<String, dynamic>{
        'nama_distributor': nama,
        'no_telepon': noTelp,
        'alamat': alamat,
      });
      print(result.toString());
      return 'berhasil';
    } catch (error) {
      print(error.message);
      return error.message;
    }
  }

  //edit section
  static Future<void> updateMerek(String id, String merek) async {
    await _merek.doc(id).set({
      'nama_merek': merek,
    });
  }

  static Future<void> updateDistributor(
      String id, String namaDistributor, String alamat, String noTelp) async {
    await _distributor.doc(id).set({
      'nama_distributor': namaDistributor,
      'alamat': alamat,
      'no_telepon': noTelp,
    });
  }
}
