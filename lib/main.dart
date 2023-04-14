import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:translator/view/second.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TranslatePage());
  }
}
