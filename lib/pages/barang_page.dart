import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter/const.dart';
import 'package:pos_flutter/widgets/menu_items.dart';

class BarangPage extends StatefulWidget {
  @override
  _BarangState createState() => _BarangState();
}

class _BarangState extends State<BarangPage> {
  void setSidebarState() {
    setState(() {
      SideBar.xoffset = SideBar.sidebarOpen ? 265 : 60;
      SideBar.yoffset = SideBar.sidebarOpen ? 70 : 0;
      SideBar.pageScale = SideBar.sidebarOpen ? 0.8 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    SideBar.selectedMenuItem = 1;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFB1F2B36),
        ),
        child: Container(
          child: Stack(
            children: [
              Container(
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
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              SideBar.sidebarOpen = false;
                              SideBar.selectedMenuItem = index;
                              setSidebarState();
                              SideBar.setPage();
                            },
                            child: MenuItems(
                              menuIcons: menuIcons[index],
                              menuItems: menuItems[index],
                              selected: SideBar.selectedMenuItem,
                              position: index,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: MenuItems(
                        menuIcons: Icons.logout,
                        menuItems: 'Logout',
                        selected: SideBar.selectedMenuItem,
                        position: menuItems.length + 1,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                transform: Matrix4.translationValues(
                    SideBar.xoffset, SideBar.yoffset, 1.0)
                  ..scale(SideBar.pageScale),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: SideBar.sidebarOpen
                      ? BorderRadius.circular(20)
                      : BorderRadius.circular(0),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 24.0),
                        height: 60.0,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                SideBar.sidebarOpen = !SideBar.sidebarOpen;
                                setSidebarState();
                              },
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(20.0),
                                child: Icon(Icons.menu),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20, bottom: 20.0),
                              child: Text(
                                'Barang Page',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
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
