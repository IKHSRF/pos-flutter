import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pos_flutter/const.dart';
import 'package:pos_flutter/pages/create/create_merek_page.dart';
import 'package:pos_flutter/pages/edit/edit_merek_page.dart';
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('merek').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
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
                                      SideBar.sidebarOpen =
                                          !SideBar.sidebarOpen;
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text(
                                      'Nama Merek',
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Container(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .6,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                        ),
                                        child: Text(
                                          'Anda bisa melihat, mengedit dan menghapus data merek di invetaris ini',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: SearchWidget(),
                                  ),
                                  SizedBox(height: 30.0),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        DocumentSnapshot document =
                                            snapshot.data.docs[index];
                                        Map<String, dynamic> merek =
                                            document.data();
                                        return Wrap(
                                          children: [
                                            LayoutBuilder(
                                              builder: (context, constraint) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 15.0,
                                                  ),
                                                  width:
                                                      constraint.maxWidth - 10,
                                                  padding: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset: Offset(0, 17),
                                                        blurRadius: 23,
                                                        spreadRadius: -13,
                                                        color: shadowColor,
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 10.0),
                                                      Expanded(
                                                        child: Text(
                                                          merek['nama_merek'],
                                                          style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                            EditMerekPage(
                                                              merek[
                                                                  'nama_merek'],
                                                              document.id,
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 43,
                                                          width: 42,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                blueLightColor,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons.edit_outlined,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Are You Sure'),
                                                                content: Text(
                                                                    'Do you want to delete ${merek['nama_merek']}?'),
                                                                actions: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                    child: Text(
                                                                        'No'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  FlatButton(
                                                                    child: Text(
                                                                        'Delete'),
                                                                    onPressed:
                                                                        () {
                                                                      document
                                                                          .reference
                                                                          .delete();
                                                                      Navigator.pop(
                                                                          context);
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 43,
                                                          width: 42,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                blueLightColor,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(CreateMerekPage());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.0),
                                      width: double.infinity,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5CEB8),
                                        borderRadius: BorderRadius.circular(13),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 17),
                                            blurRadius: 23,
                                            spreadRadius: -13,
                                            color: shadowColor,
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(Icons.add),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 20.0),
                                                child: Text(
                                                  'Tambah Merek',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 20.0),
                                                child: Text(
                                                    'Anda bisa menambahkan merek \nkedalam database'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
          );
        },
      ),
    );
  }
}
