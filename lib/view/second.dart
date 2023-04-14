import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
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

  String _sourceLang = "es";
  String _targetLang = "en";

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

  Future<void> _translate() async {
    setState(() {
      _isLoading = true;
    });

    final text = await Translate.getdata(
        text: _textEditingController1.text,
        sourceLang: _sourceLang,
        targetLang: _targetLang);

    _textEditingController2.text = text;

    setState(() {
      _isLoading = false;
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
                      Text("Source Lang: $_sourceLang"),
                      IconButton(
                        onPressed: () {
                          _showBottomSheet((value) async {
                            setState(() {
                              _sourceLang = value;
                            });
                            await _translate();
                          });
                        },
                        icon: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Target Lang: $_targetLang"),
                      IconButton(
                        onPressed: () {
                          _showBottomSheet((value) async {
                            setState(() {
                              _targetLang = value;
                            });
                            await _translate();
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
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    TextField(
                      controller: _textEditingController1,
                      decoration: InputDecoration(
                        labelText: "Source",
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _textEditingController2,
                      decoration: InputDecoration(
                        labelText: "Target",
                      ),
                    ),
                  ],
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _translate,
            child: Text("Translate"),
          ),
        ],
      ),
    );
  }
}
