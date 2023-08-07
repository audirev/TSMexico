import 'package:flutter/material.dart';
import 'package:ts_mexico/page/profile_page.dart';
import 'package:ts_mexico/page/selection_page.dart';

import 'about_page.dart';

class HomePage extends StatefulWidget {
  final List<String> colorOptions = ['Red', 'Green', 'Blue', 'Yellow'];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  
  int _selectedIndex = 0; // current selected index of the bottom navigation bar

  // list of pages that correspond to each navigation bar item
  static List<Widget> _widgetOptions = <Widget>[
    SelectionPage(), //Home   
    ProfilePage(), //Profile
    AboutPage() //About
  ];

  // callback function for when an item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // update the selected index state variable
    });
  }

  @override
  Widget build(BuildContext context) {

    // get color and text themes from the current context
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), // display the page corresponding to the selected index
      ),
      bottomNavigationBar: BottomNavigationBar(
        // configure the appearance and behavior of the bottom navigation bar
        showUnselectedLabels: true,
        selectedFontSize: textTheme.bodySmall!.fontSize!,
        unselectedFontSize: textTheme.bodySmall!.fontSize!,
        selectedItemColor: colorScheme.onPrimary,
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.38),
        backgroundColor: colorScheme.primary,

        currentIndex: _selectedIndex, // set the current selected index
        onTap: _onItemTapped, // callback function for when an item is tapped
        type: BottomNavigationBarType.fixed,
        // create the list of navigation bar items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'About',
          ),          
        ],
      ),
    );
  } 

}

