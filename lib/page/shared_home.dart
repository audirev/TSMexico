import 'package:flutter/material.dart';
import 'package:ts_mexico/page/profile_page.dart';
import 'home_page.dart';
import 'onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedHome extends StatefulWidget {
  const SharedHome({super.key});

  @override
  _SharedHomeState createState() => _SharedHomeState();
}

class _SharedHomeState extends State {  
  bool skipOnBoarding = false;
  bool filledProfile = false;

  @override
  void initState() {
    super.initState();
    loadNewLaunch();
  }

  loadNewLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool _skip = ((prefs.getBool('skipOnBoarding') ?? false));
      bool _filledProfile = ((prefs.getBool('filledProfile') ?? false));

      skipOnBoarding = _skip;
      filledProfile = _filledProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    //return Scaffold(body: skipOnBoarding ? returnContentPage() : OnBoardingPage());
    return Scaffold(body: returnContentPage());
  }

  Widget returnContentPage() {
    return filledProfile ? HomePage() : ProfilePage();
  }
}