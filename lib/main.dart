import 'package:flutter/material.dart';
import 'package:my_app/content.dart';
import 'package:my_app/searchscreen.dart';
import 'package:my_app/setting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3, // Số lượng tab
        child: Scaffold(
          appBar: AppBar(
            title: Text('MENU'),
            centerTitle: true,
            backgroundColor: Colors.deepPurple[200],
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Tìm kiếm'), // Tab với tên 'Tìm kiếm',
                Tab(
                  text: 'Mục lục', //Tab với tên 'Mục lục'
                ),
                Tab(
                  text: 'Cài đặt', //Tab với tên 'Cài đặt'
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SearchScreen(), // Màn hình tìm kiếm
              Contents(),
              Setting(),
            ],
          ),
        ),
      ),
    );
  }
}
