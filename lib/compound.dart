import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Provider.dart';
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:flutter_tts/flutter_tts.dart';
import 'Provider.dart';
import 'package:provider/provider.dart';

class Compounds extends StatefulWidget {
  const Compounds({Key? key}) : super(key: key);

  @override
  _CompoundsState createState() => _CompoundsState();
}

class _CompoundsState extends State<Compounds> {
  final FlutterTts flutterTts = FlutterTts();
  TextEditingController _formulaController = TextEditingController();
  Map<String, dynamic> _result = {};
  final String myapikey = 'WZVqbpYOgVZD7zXnK7snMQMoCmb3TJi9';

  Future<void> speakCommonName(String text) async {
    await flutterTts.speak(text);
  }

  Future<void> _searchFormulaAndFetchData() async {
    final formula = _formulaController.text;
    final searchApiUrl =
        'https://www.chemspider.com/MassSpecAPI.asmx/SearchByFormula2?formula=$formula';

    try {
      final searchResponse = await http.get(Uri.parse(searchApiUrl));

      if (searchResponse.statusCode == 200) {
        var xmlDoc = xml.XmlDocument.parse(searchResponse.body);
        String? cid = extractStringFromXml(xmlDoc);

        if (cid != null) {
          await _fetchDataForCID(cid);
        } else {
          setState(() {
            _result = {'error': 'CID not found in the XML response'};
          });
        }
      } else {
        setState(() {
          _result = {'error': 'Failed to load compound info'};
        });
      }
    } catch (e) {
      setState(() {
        _result = {'error': 'No connection !'};
      });
    }
  }

  Future<void> _fetchDataForCID(String cid) async {
    final fetchDataUrl = Uri.parse(
        'https://api.rsc.org/compounds/v1/records/$cid/details?fields=Formula,CommonName,inchi,molecularWeight,smiles');

    try {
      final fetchDataResponse = await http.get(
        fetchDataUrl,
        headers: {'apikey': myapikey},
      );

      if (fetchDataResponse.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(fetchDataResponse.body);
        print(data);

        setState(() {
          _result = data;
          if (_result.containsKey('commonName')) {
            speakCommonName(_result['commonName']);
          }
        });
      } else {
        setState(() {
          _result = {'error': 'Error: ${fetchDataResponse.statusCode}'};
        });
      }
    } catch (e) {
      setState(() {
        _result = {'error': 'Error: $e'};
      });
    }
  }

  String? extractStringFromXml(xml.XmlDocument document) {
    var ns = 'http://www.chemspider.com/';
    var stringElements = document.findAllElements('string', namespace: ns);

    if (stringElements.isNotEmpty) {
      return stringElements.first.text;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('API Request Example'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _formulaController,
                decoration: InputDecoration(
                  labelText: '  Nhập công thức hợp chất cần tìm kiếm. VD:H2SO4',
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      primary: Colors.deepPurple[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: Size(double.infinity, 40)),
                  onPressed: _searchFormulaAndFetchData,
                  child: Text(
                    'Tìm kiếm hợp chất',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.volume_up,
                      color: Colors.white,
                    ),
                    label: Text('Đọc pháp danh hợp chất.'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if (_result.containsKey('commonName') &&
                          _result['commonName'] != null &&
                          _result['commonName'] != '') {
                        speakCommonName(_result['commonName']);
                      } else {}
                    },
                  ),
                  Text('Cid: ${_result['id']}'),
                  Text(languageProvider.isEnglish
                      ? 'Common name: ${_result['commonName']}'
                      : 'Pháp danh hợp chất: ${_result['commonName']}'),
                  Text(languageProvider.isEnglish
                      ? 'Formula : ${_result['formula']}'
                      : 'Công thức : ${_result['formula']}'),
                  Text(languageProvider.isEnglish
                      ? 'Molecular Weight: ${_result['molecularWeight']}'
                      : 'Khối lượng phân tử: ${_result['molecularWeight']}'),
                  Text('Inchi : ${_result['inchi']}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
