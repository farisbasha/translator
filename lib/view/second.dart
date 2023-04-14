import 'package:flutter/material.dart';
import 'package:translator/controller/api.dart';

class TranslatePage extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();

  String _selectedLanguage1 = "es";
  String _selectedLanguage2 = "en";

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            child: Center(
              child: Text("Bottom sheet content goes here"),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Translate"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  _selectedLanguage1 = "es";
                  _selectedLanguage2 = "en";

                  final text = await Translate.getdata(
                      text: _textEditingController1.text,
                      sourceLang: _selectedLanguage1,
                      targetLang: _selectedLanguage2);

                  _textEditingController2.text = text;
                  setState(() {});
                },
                child: Text("Translate 1 to 2"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedLanguage1 = "en";
                    _selectedLanguage2 = "es";
                  });
                  _showBottomSheet();
                },
                child: Text("Translate 2 to 1"),
              ),
            ],
          ),
          TextField(
            controller: _textEditingController1,
            decoration: InputDecoration(
              labelText: "Text 1",
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _textEditingController2,
            decoration: InputDecoration(
              labelText: "Text 2",
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
