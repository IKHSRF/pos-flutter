import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter/services/database_services.dart';
import 'package:pos_flutter/widgets/field_title.dart';

class EditMerekPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final namaMerek;
  final docId;

  EditMerekPage(
    this.namaMerek,
    this.docId,
  );

  @override
  Widget build(BuildContext context) {
    var _namaMerek = namaMerek;
    return Scaffold(
      backgroundColor: Color(0xFFB1F2B36),
      body: Container(
        width: double.infinity,
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
                  Get.offAllNamed('/merek');
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
              ),
              FieldTitle(
                title: 'Edit Merek',
              ),
              SizedBox(height: 50.0),
              Form(
                key: _formkey,
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
                          hintText: namaMerek,
                        ),
                        onSaved: (value) {
                          if (value == null) {
                            _namaMerek = namaMerek;
                          } else if (value == "") {
                            _namaMerek = namaMerek;
                          } else {
                            _namaMerek = value;
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    DatabaseServices.updateMerek(docId, _namaMerek);
                    Get.offNamed('/merek');
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
    );
  }
}
