import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _merek = _firestore.collection('merek');
  static CollectionReference _distributor =
      _firestore.collection('distributor');
  static CollectionReference _barang = _firestore.collection('barang');

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
    String nama,
    String noTelp,
    String alamat,
  ) async {
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

  static Future<String> tambahBarang(
    String namaBarang,
    String namaMerek,
    String namaDistributor,
    String tanggalMasuk,
    String hargaBarang,
    String stokBarang,
    String keterangan,
  ) async {
    try {
      DocumentReference result = await _barang.add(<String, dynamic>{
        'nama_barang': namaBarang,
        'nama_merek': namaMerek,
        'nama_distributor': namaDistributor,
        'tanggal_masuk': tanggalMasuk,
        'harga_barang': hargaBarang,
        'stok_barang': stokBarang,
        'keterangan': keterangan,
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
    String id,
    String namaDistributor,
    String alamat,
    String noTelp,
  ) async {
    await _distributor.doc(id).set({
      'nama_distributor': namaDistributor,
      'alamat': alamat,
      'no_telepon': noTelp,
    });
  }

  static Future<void> updateBarang(
    String namaBarang,
    String namaMerek,
    String namaDistributor,
    String tanggalMasuk,
    String hargaBarang,
    String stokBarang,
    String keterangan,
    String id,
  ) async {
    await _barang.doc(id).set({
      'nama_barang': namaBarang,
      'nama_merek': namaMerek,
      'nama_distributor': namaDistributor,
      'tanggal_masuk': tanggalMasuk,
      'harga_barang': hargaBarang,
      'stok_barang': stokBarang,
      'keterangan': keterangan,
    });
  }

  //Get section
}
