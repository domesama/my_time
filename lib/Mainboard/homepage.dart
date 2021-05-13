import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_time/Mainboard/creatediary.dart';
import 'package:my_time/Mainboard/diarydashboard.dart';
import 'package:my_time/Mainboard/settings.dart';
import 'package:my_time/Mainboard/stickers.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("My Time")),
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "./assets/pictures/background1.png"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              DiaryDashboardPage(),
              CreateDiaryPage(),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'MY',
                          style: TextStyle(
                              fontSize: 100,
                              color: Colors.white,
                              fontFamily: "Tropical"),
                        ),
                        Text(
                          'TIME',
                          style: TextStyle(
                              fontSize: 100,
                              color: Colors.lightGreen[300],
                              fontFamily: "Tropical"),
                        ),
                      ],
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              ),
              StickersPage(),
              SettingsPage()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Diary'), icon: Icon(Icons.book)),
          BottomNavyBarItem(title: Text('Create'), icon: Icon(Icons.edit)),
          BottomNavyBarItem(title: Text('Profile'), icon: Icon(Icons.person)),
          BottomNavyBarItem(
              title: Text('RandomGifts'), icon: Icon(Icons.card_giftcard)),
          BottomNavyBarItem(
              title: Text('Settings'), icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
