import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
//import 'package:hashtagable/widgets/hashtag_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter One Liner(Under Construction)',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
            'Flutter One Liner (Under Construction)'),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: FutureBuilder<String>(
              future: getJson(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  var data = json.decode(snapshot.data);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width > 1000 ? 100.0 : MediaQuery.of(context).size.width > 500 ? 50.0 : 25.0),
                    child: GridView.builder(
                      itemCount: data['widgets'].length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 1000 ? 4 : MediaQuery.of(context).size.width > 500 ? 2 : 1),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: GridTile(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 16.0, 0.0, 16.0),
                                child: Text(data['widgets'][index]['title'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 0.0, 16.0, 16.0),
                                child: Text(
                                    data['widgets'][index]['shortExplanation'],
                                    style: TextStyle(fontSize: 18)),
                              ),
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 16.0, 16.0),
                                  child: Wrap(
                                    children: [
                                      for (var i in data['widgets'][index]
                                          ['tag'])
                                        Text("#$i ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blueGrey))
                                    ],
                                  )),
                            ],
                          )
                              //just for testing, will fill with image later
                              ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error");
                } else {
                  return Text("Error");
                }
              })), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<String> getJson() {
  return rootBundle.loadString('widgets.json');
}
