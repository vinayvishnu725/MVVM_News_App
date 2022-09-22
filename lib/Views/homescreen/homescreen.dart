import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:search_news/ViewModel/Model_provider.dart';
import 'package:search_news/Views/breaking_news/breaking_news.dart';
import 'package:search_news/Views/serach/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _modelProvider = ModelProvider();
  bool _isLoading = false;
  bool _isDataError = false;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    BreakingNewsScreen(),
    SearchNewsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    newDataProvider();
    super.initState();
  }

  Future newDataProvider() async {
    setState(() {
      _isLoading = true;
    });
    await _modelProvider.getNewsData(context).then((value) {
      // print("success $value");
      if (value) {
        setState(() {
          _isDataError = false;
        });
      } else {
        setState(() {
          _isDataError = true;
        });
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVVM News App'),
      ),
      body: Center(
        child: _isDataError
            ? const Center(
                child: Text('Data error... please check your network...'),
              )
            : _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Breaking News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Search News',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
