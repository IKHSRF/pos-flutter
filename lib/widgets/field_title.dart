import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  const FieldTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50.0),
          width: double.infinity,
          height: 3.0,
          decoration: BoxDecoration(
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
