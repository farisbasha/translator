import 'package:flutter/material.dart';
import 'package:translator/controller/api.dart';

class TranslatePage extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  @override
  void initState() {
    Translate.getLanguages().then((value) {
      setState(() {
        _languages = value;
        _isLoading = false;
      });
    });
    super.initState();
  }

  var _isLoading = true;
  var _languages = <String>[];

  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();

  String _selectedLanguage1 = "es";
  String _selectedLanguage2 = "en";

  void _showBottomSheet(Function onPressed) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 300,
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(children: [
                        ..._languages
                            .map((e) => Card(
                                  child: TextButton(
                                    onPressed: () {
                                      onPressed(e);
                                      Navigator.pop(context);
                                    },
                                    child: Text(e),
                                  ),
                                ))
                            .toList(),
                      ]),
                    ));
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text("Language 1: $_selectedLanguage1"),
                      IconButton(
                        onPressed: () {
                          _showBottomSheet((value) {
                            setState(() {
                              _selectedLanguage1 = value;
                            });
                          });
                        },
                        icon: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Language 2: $_selectedLanguage2"),
                      IconButton(
                        onPressed: () {
                          _showBottomSheet((value) {
                            setState(() {
                              _selectedLanguage2 = value;
                            });
                          });
                        },
                        icon: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  final text = await Translate.getdata(
                      text: _textEditingController1.text,
                      sourceLang: _selectedLanguage1,
                      targetLang: _selectedLanguage2);

                  _textEditingController2.text = text;
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Text("Translate 1 to 2"),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  final text = await Translate.getdata(
                      text: _textEditingController2.text,
                      sourceLang: _selectedLanguage2,
                      targetLang: _selectedLanguage1);

                  _textEditingController1.text = text;
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Text("Translate 2 to 1"),
              ),
            ],
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
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
                  ],
                ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
