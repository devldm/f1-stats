import 'package:f1stats/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import '../services/data.dart';

class MyConstructorsPage extends StatefulWidget {
  const MyConstructorsPage({Key? key, required this.title}) : super(key: key);
  static const String id = 'constructors_screen';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyConstructorsPage> createState() => _MyConstructorsPageState();
}

class _MyConstructorsPageState extends State<MyConstructorsPage> {
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
        // Here we take the value from the MyConstructorsPage object that was created by
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
        child: Text('Constructors championship page'),
      ),
      drawer: const NavDrawer(),
    );
  }
}
