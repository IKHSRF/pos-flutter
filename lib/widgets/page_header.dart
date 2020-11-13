import 'package:flutter/material.dart';
import 'package:pos_flutter/const.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .45,
      decoration: BoxDecoration(
        color: Color(0xFFF5CEB8),
        borderRadius: SideBar.sidebarOpen
            ? BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              )
            : BorderRadius.circular(0),
      ),
    );
  }
}
