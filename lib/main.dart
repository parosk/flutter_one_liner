import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_one_liner/providers/item_model.dart';
import 'package:provider/provider.dart';

import 'data/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return ItemModel()..getItems();
      },
      child: MaterialApp(
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
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openDialog(context);
          },
          child: const Icon(Icons.edit),
        ),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Flutter One Liner (Under Construction)'),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: HomeScreenContent(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 1000
              ? 100.0
              : MediaQuery.of(context).size.width > 500
                  ? 50.0
                  : 25.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              hintText: 'Search for Name',
            ),
            onChanged: (text) {
              Provider.of<ItemModel>(context, listen: false)
                  .getFilteredItems(text);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Consumer<ItemModel>(builder: (context, items, child) {

              final dataList = items.isNew ? items.itemList: items.filteredItemList;

              return GridView.builder(
                itemCount: dataList.length ,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 1000
                        ? 4
                        : MediaQuery.of(context).size.width > 500
                            ? 2
                            : 1),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: GridTile(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 16.0, 0.0, 16.0),
                          child: Text(
                              (dataList[index] as Item).title,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 16.0),
                          child: Text(
                              (dataList[index] as Item)
                                  .shortExplanation,
                              style: TextStyle(fontSize: 18)),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 16.0),
                            child: Wrap(
                              children: [
                                for (var i
                                    in (dataList[index] as Item)
                                        .tags)
                                  Text("#$i ",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.blueGrey))
                              ],
                            )),
                      ],
                    )
                        //just for testing, will fill with image later
                        ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class SomeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('DartPad'),
      ),
      body: HtmlElementView(
        // key: UniqueKey(),
        viewType: 'iframeElement',
      ),
    );
  }
}

void openDialog(BuildContext context) {
  final _url = 'https://dartpad.dev/?null_safety=true&id';
  final _iframeElement = IFrameElement()
    ..src = _url
    ..id = 'iframe'
    ..style.border = 'none';
  ui.platformViewRegistry.registerViewFactory(
    'iframeElement',
    (int viewId) => _iframeElement,
  );

  Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return SomeDialog();
      },
      fullscreenDialog: true));
}

Future<String> getJson() {
  return rootBundle.loadString('widgets.json');
}
