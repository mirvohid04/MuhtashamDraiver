import 'package:flutter/material.dart';
import 'package:food_draiver/const/sizes/textSize.dart';
import 'package:food_draiver/ui/pages/balans/BalansPage.dart';
import 'package:food_draiver/ui/pages/balans/FoodPage.dart';
import 'package:food_draiver/ui/pages/chat/ChatPage.dart';
import 'package:food_draiver/ui/pages/orders/OrderPage.dart';
import 'package:food_draiver/ui/pages/profile/ProfilePage.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[

    //OrderPage(),
    FoodPage(),
    PulPage(),
XabarlarPage(),
ProfilePage()  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.grey.shade800,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: TextSize.text11(context),
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: TextSize.text11(context),
          ),
          selectedIconTheme: IconThemeData(size: TextSize.text24(context)),
          unselectedIconTheme: IconThemeData(size: TextSize.text24(context)),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.navigation_outlined),
              activeIcon: Icon(Icons.navigation),
              label: 'Buyurmalar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet_outlined),
              activeIcon: Icon(Icons.wallet),
              label: 'Buyurmalar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Chatlar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
