import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.isEnglish
            ? 'Change language'
            : 'Chuyển đổi ngôn ngữ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              languageProvider.isEnglish
                  ? 'Change to Vietnamese'
                  : 'Chuyển sang Tiếng Anh',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                languageProvider.toggleLanguage();
              },
              child: Text(
                languageProvider.isEnglish
                    ? 'Chuyển sang Tiếng Việt'
                    : 'Change to English',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
