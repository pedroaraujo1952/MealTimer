import 'package:flutter/material.dart';
import 'package:mealtimer/pages/home.dart';
import 'package:mealtimer/pages/info.dart';
import 'package:mealtimer/pages/share.dart';

void main() => runApp(MaterialApp(
      home: MainPage(),
    ));

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

int _currentIndex = 1;

List<Widget> pages = [
  Share(),
  Home(),
  Info(),
];

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121726),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 30,
        selectedItemColor: Color(0xff69BF41),
        unselectedItemColor: Color(0xff3D5938),
        backgroundColor: Color(0xff1A3540),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            title: Text(
              "Share",
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                "Home",
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text(
                "Info",
              ))
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
