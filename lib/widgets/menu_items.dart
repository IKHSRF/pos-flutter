import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    Key key,
    @required this.menuIcons,
    @required this.menuItems,
    @required this.selected,
    @required this.position,
  }) : super(key: key);

  final IconData menuIcons;
  final String menuItems;
  final int selected;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected == position ? Color(0xFFB151E26) : Color(0xFFB1F2B36),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Icon(
              menuIcons,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              menuItems,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
