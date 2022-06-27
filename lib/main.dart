import 'package:f1stats/screens/constructorsChamp.dart';
import 'package:f1stats/screens/driversChamp.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'F1 Stats'),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(title: 'f1 home'),
        MyDriversPage.id: (context) => MyDriversPage(title: 'f1 drivers'),
        MyConstructorsPage.id: (context) =>
            MyConstructorsPage(title: 'f1 constructors'),
      },
    );
  }
}
