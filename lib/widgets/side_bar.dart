import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter/const.dart';
import 'package:pos_flutter/services/auth_services.dart';
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
    return FutureBuilder(
      future: AuthServices.getUserRole(FirebaseAuth.instance.currentUser.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
                  itemCount: snapshot.data['role'] == 'Admin'
                      ? adminMenuItems.length
                      : snapshot.data['role'] == 'Manager'
                          ? managerMenuItems.length
                          : kasirMenuItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        SideBar.sidebarOpen = false;
                        SideBar.selectedMenuItem = index;
                        setSidebarState();
                        if (snapshot.data['role'] == 'Admin') {
                          SideBar.setPageAdmin();
                        } else if (snapshot.data['role'] == 'Manager') {
                          SideBar.setPageManager();
                        } else {
                          SideBar.setPageKasir();
                        }
                      },
                      child: MenuItems(
                        menuIcons: (snapshot.data['role'] == 'Admin')
                            ? adminMenuIcons[index]
                            : (snapshot.data['role'] == 'Manager')
                                ? managerMenuIcons[index]
                                : kasirMenuIcons[index],
                        menuItems: (snapshot.data['role'] == 'Admin')
                            ? adminMenuItems[index]
                            : (snapshot.data['role'] == 'Manager')
                                ? managerMenuItems[index]
                                : kasirMenuItems[index],
                        selected: SideBar.selectedMenuItem,
                        position: index,
                      ),
                    );
                  },
                ),
              ),
              LogOut(
                position: (snapshot.data['role'] == 'Admin')
                    ? adminMenuItems
                    : (snapshot.data['role'] == 'Manager')
                        ? managerMenuItems
                        : kasirMenuItems,
              ),
            ],
          ),
        );
      },
    );
  }
}
