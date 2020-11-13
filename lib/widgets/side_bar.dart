import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter/const.dart';
import 'package:pos_flutter/widgets/logout.dart';
import 'package:pos_flutter/widgets/menu_items.dart';

class SideBarMenu extends StatefulWidget {
  @override
  _SideBarMenuState createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  void setSidebarState() {
    setState(() {
      SideBar.xoffset = SideBar.sidebarOpen ? 265 : 0;
      SideBar.yoffset = SideBar.sidebarOpen ? 70 : 0;
      SideBar.pageScale = SideBar.sidebarOpen ? 0.8 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(top: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFB1F2B36),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      SideBar.sidebarOpen = true;
                      setSidebarState();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20.0),
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            color: Color(0xFFB666666),
                          ),
                        ),
                        //ini input style
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        readOnly: true,
                        onTap: () {
                          Get.snackbar(
                            'Mohon Maaf',
                            'Fitur search belum tersedia',
                            colorText: Colors.white,
                            backgroundColor: Colors.red,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: adminMenuItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    SideBar.sidebarOpen = false;
                    SideBar.selectedMenuItem = index;
                    setSidebarState();
                    SideBar.setPageAdmin();
                  },
                  child: MenuItems(
                    menuIcons: adminMenuIcons[index],
                    menuItems: adminMenuItems[index],
                    selected: SideBar.selectedMenuItem,
                    position: index,
                  ),
                );
              },
            ),
          ),
          LogOut(),
        ],
      ),
    );
  }
}
