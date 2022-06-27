import 'package:flutter/material.dart';
import '../services/data.dart';
import 'constructorsChamp.dart';
import 'home.dart';

class MyDriversPage extends StatefulWidget {
  const MyDriversPage({Key? key, required this.title}) : super(key: key);
  static const String id = 'drivers_screen';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyDriversPage> createState() => _MyDriversPageState();
}

class _MyDriversPageState extends State<MyDriversPage> {
  late Future<List<Result>> futureResult;

  @override
  void initState() {
    super.initState();
    futureResult = fetchResult();
  }

  void refresh() {
    setState(() {
      futureResult = fetchResult();
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyDriversPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refresh,
          )
        ],
      ),
      body: const Center(
        child: Text('drivers championship page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('F1 Stats'),
            ),
            ListTile(
              title: const Text('Race Results'),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pushNamed(context, MyHomePage.id);
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Drivers Championship'),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pushNamed(context, MyDriversPage.id);
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Constructors Championship'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushNamed(context, MyConstructorsPage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
