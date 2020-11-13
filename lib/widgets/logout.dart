import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter/const.dart';
import 'package:pos_flutter/services/auth_services.dart';
import 'package:pos_flutter/widgets/menu_items.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AuthServices.signOut();
        Get.offNamed('/');
      },
      child: Container(
        child: MenuItems(
          menuIcons: Icons.logout,
          menuItems: 'Logout',
          selected: SideBar.selectedMenuItem,
          position: adminMenuItems.length + 1,
        ),
      ),
    );
  }
}
