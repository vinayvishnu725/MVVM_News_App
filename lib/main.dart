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
