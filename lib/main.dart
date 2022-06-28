import 'package:f1stats/screens/constructors_championship.dart';
import 'package:f1stats/screens/drivers_championship.dart';
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
        MyHomePage.id: (context) => const MyHomePage(title: 'Race Results'),
        MyDriversPage.id: (context) =>
            const MyDriversPage(title: 'Drivers Championship'),
        MyConstructorsPage.id: (context) =>
            const MyConstructorsPage(title: 'Constructors Championship'),
      },
    );
  }
}
