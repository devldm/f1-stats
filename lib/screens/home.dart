import 'package:flutter/material.dart';
import '../services/data.dart';
import '../widgets/nav_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  static const String id = 'home_screen';
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Result>> futureResult;
  late Future<List<Race>> futureResultRaces;
  String value = '1';

  @override
  void initState() {
    super.initState();
    futureResult = fetchResult();
    futureResultRaces = fetchRaces();
  }

  void refresh() {
    setState(() {
      futureResult = fetchResult(value);
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
      body: Column(
        children: [
          FutureBuilder<List<Race>>(
            future: futureResultRaces,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return DropdownButton<String>(
                  value: value,
                  onChanged: (String? newValue) {
                    setState(() {
                      value = newValue!;
                      futureResult = fetchResult(newValue);
                    });
                  },
                  items: snapshot.data!
                      .map((value) => DropdownMenuItem<String>(
                            value: value.round,
                            child: Text(value.raceName),
                          ))
                      .toList(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          Expanded(
            child: FutureBuilder<List<Result>>(
              future: futureResult,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.length <= 0) {
                  return const Center(
                      child:
                          Text("No results yet. Check back after the race!"));
                }
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ListView.builder(
                      clipBehavior: Clip.hardEdge,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              snapshot.data![index].status !=
                                                      'Finished'
                                                  ? Colors.red.shade600
                                                  : Colors.blue,
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
                                              snapshot
                                                  .data![index].driver!.code,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              snapshot
                                                  .data![index].driver!.name,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                // color: Colors.grey.shade700
                                              ),
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![index].constructor!
                                                  .name,
                                              textAlign: TextAlign.left,
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    'FL: ${snapshot.data![index].fastestLap}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          snapshot.data![index].points,
                                          style: const TextStyle(fontSize: 20),
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
          ),
        ],
      ),
      drawer: const NavDrawer(),
    );
  }
}
