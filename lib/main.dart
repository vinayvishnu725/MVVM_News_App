import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_news/Models/news_model.dart';
import 'package:search_news/ViewModel/model_provider.dart';
import 'package:search_news/Views/homescreen/homescreen.dart';
import 'package:search_news/utils/config.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<NewsModel>(create: ((context) => NewsModel()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        //sizeConfiguration
        SizeConfig().init(constraints, orientation);
        return const MaterialApp(
          title: 'MVVM News App',
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      });
    });
  }
}

class StorageUpload extends StatefulWidget {
  const StorageUpload({Key? key}) : super(key: key);

  @override
  StorageUploadState createState() => new StorageUploadState();
}

class StorageUploadState extends State<StorageUpload> {
  List results = [];

  var rows = [];
  String query = '';
  TextEditingController tc = TextEditingController();
  final _modelProvider = ModelProvider();

  @override
  void initState() {
    super.initState();
    tc = TextEditingController();
    _modelProvider.getNewsData(context);

    rows = [
      {
        'contact_name': 'Test User 1',
        'contact_phone': '066 560 4900',
      },
      {
        'contact_name': 'Test User 2',
        'contact_phone': '066 560 7865',
      },
      {
        'contact_name': 'Test User 3',
        'contact_phone': '906 500 4334',
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Delivero Contacts",
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: tc,
                    decoration: InputDecoration(hintText: 'Search...'),
                    onChanged: (v) {
                      setState(() {
                        query = v;
                        setResults(query);
                      });
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: query.isEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: rows.length,
                          itemBuilder: (con, ind) {
                            return ListTile(
                              title: Text(rows[ind]['contact_name']),
                              subtitle: Text(rows[ind]['contact_phone']),
                              onTap: () {
                                setState(() {
                                  tc.text = rows[ind]['contact_name'];
                                  query = rows[ind]['contact_name'];
                                  setResults(query);
                                });
                              },
                            );
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: results.length,
                          itemBuilder: (con, ind) {
                            return ListTile(
                              title: Text(results[ind]['contact_name']),
                              subtitle: Text(results[ind]['contact_phone']),
                              onTap: () {
                                setState(() {
                                  tc.text = results[ind]['contact_name'];
                                  query = results[ind]['contact_name'];
                                  setResults(query);
                                });
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void setResults(String query) {
    results = rows
        .where((elem) =>
            elem['contact_name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            elem['contact_phone']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();
  }
}
