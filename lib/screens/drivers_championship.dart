import 'package:f1stats/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import '../services/data.dart';

class MyDriversPage extends StatefulWidget {
  const MyDriversPage({Key? key, required this.title}) : super(key: key);
  static const String id = 'drivers_screen';
  final String title;

  @override
  State<MyDriversPage> createState() => _MyDriversPageState();
}

class _MyDriversPageState extends State<MyDriversPage> {
  late Future<List<Result>> futureDriversChampResult;

  @override
  void initState() {
    super.initState();
    futureDriversChampResult = fetchDriversChampResult();
  }

  void refresh() {
    setState(() {
      futureDriversChampResult = fetchDriversChampResult();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refresh,
          )
        ],
      ),
      body: FutureBuilder<List<Result>>(
        future: futureDriversChampResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                      snapshot.data![index].position,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].driver!.code,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        snapshot.data![index].driver!.name,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data![index].constructor?.name ??
                                        "none",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    snapshot.data![index].points,
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
      drawer: const NavDrawer(),
    );
  }
}
