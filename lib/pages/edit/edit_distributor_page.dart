import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter/services/database_services.dart';
import 'package:pos_flutter/widgets/field_title.dart';

class EditDistributorPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final namaDistributor;
  final alamat;
  final noTelp;
  final docId;

  EditDistributorPage(
    this.namaDistributor,
    this.alamat,
    this.noTelp,
    this.docId,
  );

  @override
  Widget build(BuildContext context) {
    var _namaDistributor = namaDistributor;
    var _alamat = alamat;
    var _noTelp = noTelp;
    return Scaffold(
      backgroundColor: Color(0xFFB1F2B36),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 40.0,
          margin: EdgeInsets.all(30.0),
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
                                    hintText: namaDistributor),
                                onSaved: (value) {
                                  if (value == null) {
                                    _namaDistributor = namaDistributor;
                                  } else if (value == "") {
                                    _namaDistributor = namaDistributor;
                                  } else {
                                    _namaDistributor = value;
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
                                  'Alamat',
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
                                  hintText: alamat,
                                ),
                                onSaved: (value) {
                                  if (value == null) {
                                    _alamat = alamat;
                                  } else if (value == "") {
                                    _alamat = alamat;
                                  } else {
                                    _alamat = value;
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
                                  'No Telepon',
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
                                  hintText: noTelp,
                                ),
                                onSaved: (value) {
                                  if (value == null) {
                                    _noTelp = noTelp;
                                  } else if (value == "") {
                                    _noTelp = noTelp;
                                  } else {
                                    _noTelp = value;
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
                      DatabaseServices.updateDistributor(
                          docId, _namaDistributor, _alamat, _noTelp);
                      Get.offNamed('/distributor');
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
