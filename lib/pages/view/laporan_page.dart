import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter/const.dart';
import 'package:pos_flutter/pages/create/create_barang_page.dart';
import 'package:pos_flutter/pages/detail/detail_barang_page.dart';
import 'package:pos_flutter/pages/edit/edit_barang_page.dart';
import 'package:pos_flutter/widgets/page_header.dart';
import 'package:pos_flutter/widgets/search_widget.dart';
import 'package:pos_flutter/widgets/side_bar.dart';

class LaporanPage extends StatefulWidget {
  @override
  _LaporanState createState() => _LaporanState();
}

class _LaporanState extends State<LaporanPage> {
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
        stream: FirebaseFirestore.instance.collection('laporan').snapshots(),
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
                    transform: Matrix4.translationValues(SideBar.xoffset, SideBar.yoffset, 1.0)..scale(SideBar.pageScale),
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: SideBar.sidebarOpen ? BorderRadius.circular(20) : BorderRadius.circular(0),
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text(
                                      'Laporan',
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Container(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * .6,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                        ),
                                        child: Text(
                                          'Anda bisa melihat, mengedit dan menghapus Laporan di invetaris ini',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: SearchWidget(),
                                  ),
                                  SizedBox(height: 30.0),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        DocumentSnapshot document = snapshot.data.docs[index];
                                        Map<String, dynamic> laporan = document.data();
                                        return Wrap(
                                          children: [
                                            LayoutBuilder(
                                              builder: (context, constraint) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 15.0,
                                                  ),
                                                  width: constraint.maxWidth - 10,
                                                  padding: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
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
                                                      SizedBox(width: 10.0),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              laporan['nama_barang'],
                                                              style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                            Text(
                                                              laporan['nama_user'],
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          laporan['tanggal_beli'],
                                                          style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                            DetailBarangPage(
                                                              docId: document.id,
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 43,
                                                          width: 42,
                                                          decoration: BoxDecoration(
                                                            color: blueLightColor,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons.zoom_in_sharp,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                            EditBarangPage(
                                                              laporan['nama_barang'],
                                                              laporan['nama_merek'],
                                                              laporan['nama_distributor'],
                                                              laporan['tanggal_masuk'],
                                                              laporan['harga_barang'],
                                                              laporan['stok_barang'],
                                                              laporan['keterangan'],
                                                              document.id,
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 43,
                                                          width: 42,
                                                          decoration: BoxDecoration(
                                                            color: blueLightColor,
                                                            shape: BoxShape.circle,
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
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                title: Text('Are You Sure'),
                                                                content: Text('Do you want to delete ${laporan['nama_barang']}?'),
                                                                actions: <Widget>[
                                                                  FlatButton(
                                                                    child: Text('No'),
                                                                    onPressed: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                  ),
                                                                  FlatButton(
                                                                    child: Text('Delete'),
                                                                    onPressed: () {
                                                                      document.reference.delete();
                                                                      Navigator.pop(context);
                                                                      setState(() {});
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
                                                          decoration: BoxDecoration(
                                                            color: blueLightColor,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons.delete_outline,
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
                                      Get.to(
                                        CreateBarangPage(),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 40.0),
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 20.0),
                                                child: Text(
                                                  'Tambah Barang',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: 20.0),
                                                child: Text('Anda bisa menambahkan barang \nkedalam database'),
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
