import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter/services/database_services.dart';
import 'package:pos_flutter/widgets/field_title.dart';

class EditBarangPage extends StatefulWidget {
  final namaBarangEdit;
  final namaMerekEdit;
  final namaDistributorEdit;
  final tanggalMasukEdit;
  final hargaBarangEdit;
  final stokBarangEdit;
  final keteranganEdit;
  final docId;

  EditBarangPage(
    this.namaBarangEdit,
    this.namaMerekEdit,
    this.namaDistributorEdit,
    this.tanggalMasukEdit,
    this.hargaBarangEdit,
    this.stokBarangEdit,
    this.keteranganEdit,
    this.docId,
  );

  @override
  _EditBarangPageState createState() => _EditBarangPageState();
}

class _EditBarangPageState extends State<EditBarangPage> {
  var namaMerek;
  var namaDistributor;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var namaBarang = widget.namaBarangEdit;
    var tanggalMasuk = widget.tanggalMasukEdit;
    var hargaBarang = widget.hargaBarangEdit;
    var stokBarang = widget.stokBarangEdit;
    var keterangan = widget.keteranganEdit;
    DateTime now = DateTime.now();
    var formatter = DateFormat('yy-MM-dd');
    String formattedDate = formatter.format(now);

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
                    Get.offAllNamed('/distributor');
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
                FieldTitle(
                  title: 'Edit Distributor',
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
                                  hintText: widget.namaBarangEdit,
                                ),
                                onSaved: (value) {
                                  if (value == null) {
                                    namaBarang = widget.namaBarangEdit;
                                  } else if (value == "") {
                                    namaBarang = widget.namaBarangEdit;
                                  } else {
                                    namaBarang = value;
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
                                  'Nama Merek',
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
                              stream: FirebaseFirestore.instance
                                  .collection('merek')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                return Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 40.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: DropdownButton(
                                    hint: Text(widget.namaMerekEdit),
                                    value: namaMerek,
                                    onChanged: (value) {
                                      setState(() {
                                        namaMerek = value;
                                      });
                                    },
                                    items: snapshot.data.docs.map(
                                      (DocumentSnapshot document) {
                                        return DropdownMenuItem<String>(
                                          value: document.data()['nama_merek'],
                                          child: Text(
                                            document.data()['nama_merek'],
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
                                  'Nama Distributor',
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
                              stream: FirebaseFirestore.instance
                                  .collection('distributor')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                return Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 40.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: DropdownButton(
                                    hint: Text(widget.namaDistributorEdit),
                                    value: namaDistributor,
                                    onChanged: (value) {
                                      setState(() {
                                        namaDistributor = value;
                                      });
                                    },
                                    items: snapshot.data.docs.map(
                                      (DocumentSnapshot document) {
                                        return DropdownMenuItem<String>(
                                          value: document
                                              .data()['nama_distributor'],
                                          child: Text(
                                            document.data()['nama_distributor'],
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
                                  'Tanggal Masuk',
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
                                  hintText: widget.tanggalMasukEdit,
                                ),
                                readOnly: true,
                                onSaved: (value) {
                                  if (value == null) {
                                    tanggalMasuk = widget.tanggalMasukEdit;
                                  } else if (value == "") {
                                    tanggalMasuk = widget.tanggalMasukEdit;
                                  } else {
                                    tanggalMasuk = formattedDate;
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
                                  'Harga Barang',
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
                                  hintText: widget.hargaBarangEdit,
                                ),
                                onSaved: (value) {
                                  if (value == null) {
                                    hargaBarang = widget.hargaBarangEdit;
                                  } else if (value == "") {
                                    hargaBarang = widget.hargaBarangEdit;
                                  } else {
                                    hargaBarang = value;
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
                                  'Stok Barang',
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
                                  hintText: widget.stokBarangEdit,
                                ),
                                onSaved: (value) {
                                  if (value == null) {
                                    stokBarang = widget.stokBarangEdit;
                                  } else if (value == "") {
                                    stokBarang = widget.stokBarangEdit;
                                  } else {
                                    stokBarang = value;
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
                                  'Keterangan',
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
                                  hintText: widget.keteranganEdit,
                                ),
                                onSaved: (value) {
                                  if (value == null) {
                                    keterangan = widget.keteranganEdit;
                                  } else if (value == "") {
                                    keterangan = widget.keteranganEdit;
                                  } else {
                                    keterangan = value;
                                  }
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
                      if (namaDistributor == null && namaMerek == null) {
                        namaDistributor = widget.namaDistributorEdit;
                        namaMerek = widget.namaMerekEdit;
                      }
                      DatabaseServices.updateBarang(
                        namaBarang,
                        namaMerek,
                        namaDistributor,
                        tanggalMasuk,
                        hargaBarang,
                        stokBarang,
                        keterangan,
                        widget.docId,
                      );
                      Get.offNamed('/barang');
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
