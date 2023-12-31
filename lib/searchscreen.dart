import 'package:flutter/material.dart';
import 'package:my_app/chemical_symbol.dart';
import 'package:my_app/detail_symbol.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<chemicalsymbol> searchResults = [];

  void search(String query) {
    setState(() {
      searchResults = libary
          .where((libary) =>
              libary.symbol.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void navigateToSymbolDetail(chemicalsymbol detailsymbol) {
    Navigator.of(context as BuildContext).push(
      MaterialPageRoute(
        builder: (context) => DetailSymbol(detailsymbol: detailsymbol),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                labelText: 'Nhập kí hiệu nguyên tố cần tìm kiếm',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      "Kí hiệu: ${searchResults[index].symbol}, Pháp danh: ${searchResults[index].nomenclature}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Số thự tự trong bảng tuần hoàn: ${searchResults[index].chemicalelementnumber}"),
                      Text(
                          "Nguyên tử khối: ${searchResults[index].atomicblock}"),
                    ],
                  ),
                  onTap: () {
                    navigateToSymbolDetail(searchResults[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
