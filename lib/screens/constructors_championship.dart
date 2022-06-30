import 'package:f1stats/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import '../services/data.dart';

class MyConstructorsPage extends StatefulWidget {
  const MyConstructorsPage({Key? key, required this.title}) : super(key: key);
  static const String id = 'constructors_screen';
  final String title;

  @override
  State<MyConstructorsPage> createState() => _MyConstructorsPageState();
}

class _MyConstructorsPageState extends State<MyConstructorsPage> {
  late Future<List<Result>> futureConstructorsResult;

  @override
  void initState() {
    super.initState();
    futureConstructorsResult = fetchConstructorsChampResult();
  }

  void refresh() {
    setState(() {
      futureConstructorsResult = fetchConstructorsChampResult();
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
        future: futureConstructorsResult,
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
                                  Text(
                                    snapshot.data![index].constructor?.name ??
                                        "none",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data![index].points,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      )
                                    ],
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
