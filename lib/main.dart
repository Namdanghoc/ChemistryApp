import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'compound.dart';
import 'content.dart';
import 'setting.dart';
import 'searchscreen.dart';
import 'Provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('MENU'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple[200],
          bottom: TabBar(
            tabs: [
              Tab(text: languageProvider.isEnglish ? 'Element' : 'Nguyên tố'),
              Tab(text: languageProvider.isEnglish ? 'Compound' : 'Hợp chất'),
              Tab(text: languageProvider.isEnglish ? 'Library' : 'Mục lục'),
              Tab(text: languageProvider.isEnglish ? 'Setting' : 'Cài đặt'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchScreen(),
            Compounds(),
            Contents(),
            Setting(),
          ],
        ),
      ),
    );
  }
}
