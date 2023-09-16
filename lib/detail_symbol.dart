import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'chemical_symbol.dart';

class DetailSymbol extends StatelessWidget {
  final chemicalsymbol detailsymbol;
  DetailSymbol({required this.detailsymbol});

  final player = AudioPlayer();

  void playSound() async {
    await player.play(AssetSource('assets/audio/Bản ghi Mới.mp4'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${detailsymbol.symbol}'),
        actions: [
          ElevatedButton(
              onPressed: () {
                playSound();
              },
              child: Icon(Icons.volume_up))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 500,
              height: 500,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/${detailsymbol.chemicalelementnumber}.jpg'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Pháp danh: ${detailsymbol.nomenclature}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Số thứ tự trong bảng tuần hoàn: ${detailsymbol.chemicalelementnumber}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Nguyên tử khối: ${detailsymbol.atomicblock}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Màu sắc: ${detailsymbol.color}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Trạng thái: ${detailsymbol.state}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Phân loại: ${detailsymbol.classify}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Cấu hình e: ${detailsymbol.electron}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
