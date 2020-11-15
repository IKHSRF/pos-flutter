import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter/widgets/field_title.dart';

class DetailTransaksiPage extends StatefulWidget {
  final docId;

  DetailTransaksiPage({
    this.docId,
  });

  @override
  _DetailTransaksiPageState createState() => _DetailTransaksiPageState();
}

class _DetailTransaksiPageState extends State<DetailTransaksiPage> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('transaksi').doc(widget.docId).get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Form(
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
                                      hintText: snapshot.data['nama_barang'],
                                    ),
                                    readOnly: true,
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
                                      hintText: snapshot.data['nama_user'],
                                    ),
                                    readOnly: true,
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
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: snapshot.data['jumlah_beli'].toString(),
                                    ),
                                    readOnly: true,
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
                                      hintText: snapshot.data['total_harga'].toString(),
                                    ),
                                    readOnly: true,
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
                                      hintText: snapshot.data['tanggal_beli'],
                                    ),
                                    readOnly: true,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
