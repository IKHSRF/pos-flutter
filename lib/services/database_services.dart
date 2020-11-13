import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _merek = _firestore.collection('merek');

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

  static Future<void> updateMerek(String id, String merek) async {
    await _merek.doc(id).set({
      'nama_merek': merek,
    });
  }
}
