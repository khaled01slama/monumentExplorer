import 'package:explorer/monument_list_screen.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';


void main() {
  runApp(MonumentExplorerApp());
}

class MonumentExplorerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/monuments': (context) =>MonumentListScreen(),
      },
    );
  }
}
