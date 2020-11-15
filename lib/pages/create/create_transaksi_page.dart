import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter/services/database_services.dart';
import 'package:pos_flutter/widgets/field_title.dart';

class CreateTransaksiPage extends StatefulWidget {
  @override
  _CreateTransaksiPageState createState() => _CreateTransaksiPageState();
}

class _CreateTransaksiPageState extends State<CreateTransaksiPage> {
  String namaBarang;
  String namaUser;
  int jumlahBeli = 0;
  int totalHarga = 0;
  String tanggalBeli;
  int hargaBarang = 0;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var formatter = DateFormat('yy-MM-dd');
    String formattedDate = formatter.format(now);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFB1F2B36),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(30.0),
          padding: EdgeInsets.only(bottom: 40.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed('/transaksi');
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
                FieldTitle(
                  title: 'Tambah Transaksi',
                ),
                SizedBox(height: 50.0),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Nama User',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .4,
                                height: 3.0,
                                decoration: BoxDecoration(color: Colors.green),
                              ),
                            ),
                            FutureBuilder(
                              future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Container(
                                  margin: EdgeInsets.only(top: 10.0, bottom: 40.0),
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: snapshot.data['nama'],
                                    ),
                                    onSaved: (value) {
                                      namaUser = snapshot.data['nama'];
                                    },
                                    readOnly: true,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Nama Barang',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .4,
                                height: 3.0,
                                decoration: BoxDecoration(color: Colors.green),
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('barang').snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Container(
                                  margin: EdgeInsets.only(top: 10.0, bottom: 40.0),
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: DropdownButton(
                                    hint: Text('Nama Barang'),
                                    value: namaBarang,
                                    onChanged: (value) {
                                      print(value);

                                      setState(() {
                                        namaBarang = value;
                                      });
                                      print(namaBarang);
                                      print(hargaBarang);
                                    },
                                    items: snapshot.data.docs.map(
                                      (DocumentSnapshot document) {
                                        return DropdownMenuItem<String>(
                                          value: document.data()['nama_barang'],
                                          onTap: () {
                                            setState(() {
                                              hargaBarang = document.data()['harga_barang'];
                                            });
                                          },
                                          child: Text(
                                            document.data()['nama_barang'],
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Jumlah Beli',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .4,
                                height: 3.0,
                                decoration: BoxDecoration(color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 40.0),
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Jumlah Beli',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    jumlahBeli = int.parse(value);
                                  });
                                },
                                onSaved: (value) {
                                  jumlahBeli = int.parse(value);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Total Harga',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .4,
                                height: 3.0,
                                decoration: BoxDecoration(color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 40.0),
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: (jumlahBeli == 0) //kalo jumlah beli nya belum disi, yang tampil harga barang saja
                                      ? hargaBarang.toString()
                                      : (hargaBarang == 0) //kalo harga barang nya belum diisi, yang tampil jumlah belinya saha
                                          ? jumlahBeli.toString()
                                          : (jumlahBeli != 0 && hargaBarang != 0) //kalo dua duanya udah diisi, yang tampil hasil perkalian keduanya
                                              ? (jumlahBeli * hargaBarang).toString()
                                              : 'Total Harga', //kalo dua duanya belum disii, yang tampil total harga saat ini, yaitu 0
                                ),
                                readOnly: true,
                                onSaved: (value) {
                                  totalHarga = jumlahBeli * hargaBarang;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Tanggal Beli',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .4,
                                height: 3.0,
                                decoration: BoxDecoration(color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 40.0),
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: formattedDate,
                                ),
                                readOnly: true,
                                onSaved: (value) {
                                  tanggalBeli = formattedDate;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formkey.currentState.validate()) {
                      _formkey.currentState.save();
                      var result = await DatabaseServices.tambahTransaksi(
                        namaBarang,
                        namaUser,
                        jumlahBeli,
                        totalHarga,
                        tanggalBeli,
                      );
                      if (result != 'berhasil') {
                        Get.snackbar('Oop ada yang error', result);
                      } else {
                        Get.offNamed('/transaksi');
                      }
                    }
                  },
                  child: Container(
                    alignment: AlignmentDirectional.bottomCenter,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
