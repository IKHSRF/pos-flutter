import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          icon: Icon(Icons.search),
          border: InputBorder.none,
        ),
        readOnly: true,
        onTap: () {
          Get.snackbar(
            'Mohon Maaf',
            'Fitur Search Belum Tersedia',
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        },
      ),
    );
  }
}
