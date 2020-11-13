import 'package:flutter/material.dart';

class FieldCreate extends StatelessWidget {
  const FieldCreate({
    Key key,
    @required this.title,
    @required this.hint,
  }) : super(key: key);

  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                title,
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
                hintText: hint,
              ),
            ),
          )
        ],
      ),
    );
  }
}
