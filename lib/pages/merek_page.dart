import 'package:flutter/material.dart';
import 'package:pos_flutter/const.dart';
import 'package:pos_flutter/widgets/page_header.dart';
import 'package:pos_flutter/widgets/search_widget.dart';
import 'package:pos_flutter/widgets/side_bar.dart';

class MerekPage extends StatefulWidget {
  @override
  _MerekState createState() => _MerekState();
}

class _MerekState extends State<MerekPage> {
  void setSidebarState() {
    setState(() {
      SideBar.xoffset = SideBar.sidebarOpen ? 265 : 0;
      SideBar.yoffset = SideBar.sidebarOpen ? 70 : 0;
      SideBar.pageScale = SideBar.sidebarOpen ? 0.8 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFB1F2B36),
        ),
        child: Container(
          child: Stack(
            children: [
              SideBarMenu(),
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
                child: Stack(
                  children: [
                    PageHeader(),
                    Column(
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
                                  padding: EdgeInsets.all(20.0),
                                  child: Icon(Icons.menu),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Page Merek',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .6,
                                child: Text(
                                  'Anda bisa melihat, mengedit dan menghapus data merek di invetaris ini',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              SearchWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
