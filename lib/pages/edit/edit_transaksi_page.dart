import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter/services/database_services.dart';
import 'package:pos_flutter/widgets/field_title.dart';

class EditTransaksiPage extends StatefulWidget {
  final String namaBarangEdit;
  final String namaUserEdit;
  final num jumlahBeliEdit;
  final num totalHargaEdit;
  final String tanggalBeliEdit;
  final docId;

  EditTransaksiPage(
    this.namaBarangEdit,
    this.namaUserEdit,
    this.jumlahBeliEdit,
    this.totalHargaEdit,
    this.tanggalBeliEdit,
    this.docId,
  );

  @override
  _EditTransaksiPageState createState() => _EditTransaksiPageState();
}

class _EditTransaksiPageState extends State<EditTransaksiPage> {
  String namaBarang;
  num hargaBarang = 0;
  num jumlahBeli = 0;
  num totalHarga = 0;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String namaUser = widget.namaUserEdit;
    String tanggalBeli = widget.tanggalBeliEdit;

    return Scaffold(
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
                  title: 'Edit Transaksi',
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
                                  hintText: widget.namaUserEdit,
                                ),
                                readOnly: true,
                                onSaved: (value) {
                                  namaUser = widget.namaUserEdit;
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
                                    hint: Text(widget.namaBarangEdit),
                                    value: namaBarang,
                                    onChanged: (value) {
                                      setState(() {
                                        namaBarang = value;
                                      });
                                      print(hargaBarang);
                                    },
                                    items: snapshot.data.docs.map(
                                      (DocumentSnapshot document) {
                                        return DropdownMenuItem<String>(
                                          onTap: () {
                                            setState(() {
                                              hargaBarang = document.data()['harga_barang'];
                                              print(hargaBarang);
                                            });
                                          },
                                          value: document.data()['nama_barang'],
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
                                  hintText: widget.jumlahBeliEdit.toString(),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    jumlahBeli = num.parse(value);
                                  });
                                },
                                onSaved: (value) {
                                  if (value == "" || value == null) {
                                    jumlahBeli = widget.jumlahBeliEdit;
                                  } else {
                                    jumlahBeli = num.parse(value);
                                  }
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
                                  hintText: (jumlahBeli == 0 && hargaBarang != 0)
                                      ? (widget.jumlahBeliEdit * hargaBarang).toString()
                                      : (hargaBarang == 0 && jumlahBeli != 0)
                                          ? (jumlahBeli * (widget.totalHargaEdit / widget.jumlahBeliEdit)).toString()
                                          : (jumlahBeli == 0 && hargaBarang == 0)
                                              ? (widget.totalHargaEdit).toString()
                                              : (jumlahBeli * hargaBarang).toString(),
                                ),
                                readOnly: true,
                                onSaved: (value) {
                                  if (jumlahBeli == 0) {
                                    totalHarga = widget.jumlahBeliEdit * hargaBarang;
                                  } else if (hargaBarang == 0) {
                                    totalHarga = jumlahBeli * (widget.totalHargaEdit / widget.jumlahBeliEdit);
                                  } else if (hargaBarang == 0 && jumlahBeli == 0) {
                                    totalHarga = widget.totalHargaEdit;
                                  } else {
                                    totalHarga = jumlahBeli * hargaBarang;
                                  }
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
                                  hintText: widget.tanggalBeliEdit,
                                ),
                                readOnly: true,
                                onSaved: (value) {
                                  tanggalBeli = widget.tanggalBeliEdit;
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
                      if (namaBarang == null) {
                        namaBarang = widget.namaBarangEdit;
                      }
                      DatabaseServices.updateTransaksi(
                        namaBarang,
                        namaUser,
                        jumlahBeli,
                        totalHarga,
                        tanggalBeli,
                        widget.docId,
                      );
                      Get.offNamed('/transaksi');
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
