import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ts_mexico/page/home_page.dart';
import 'package:ts_mexico/page/profile_page.dart';
import 'package:ts_mexico/widget/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  _OnBoardingPage createState() => _OnBoardingPage();
}

class _OnBoardingPage extends State<OnBoardingPage> {
  bool filledProfile = false;

  @override
  void initState() {
    super.initState();
    loadNewLaunch();
  }

   loadNewLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool _filledProfile = ((prefs.getBool('filledProfile') ?? false));
      filledProfile = _filledProfile;
    });
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'A moment you will never forget',
              body: 'Make it simply with just an app',
              image: buildImage('assets/ebook.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Learn about it',
              body: 'Available on every platform',
              image: buildImage('assets/readingbook.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Simple UI',
              body: 'For enhanced experience',
              image: buildImage('assets/manthumbs.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Get around',
              body: 'Start your experience',
              footer: Center(
                child: ButtonWidget(
                  text: "Let's go!",
                  onClicked: () => skipOnBoarding(context),
                )
              ),
              image: buildImage('assets/learn.png'),
              decoration: getPageDecoration()              
            ),
          ],
          done: Text('Go', style: TextStyle(fontWeight: FontWeight.w600)),
          onDone: () => skipOnBoarding(context),
          showSkipButton: true,
          skip: Text('Skip'),
          onSkip: () => skipOnBoarding(context),
          next: Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(context),
          onChange: (index) => print('Page $index selected'),
          // globalBackgroundColor: Theme.of(context).primaryColor,
          // skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  void skipOnBoarding(contest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('skipOnBoarding', true);
    });
    goToHome(context);
  }

  void goToHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => returnContentPage()),
  );

  Widget returnContentPage() {
    return filledProfile ? HomePage() : ProfilePage();
  }

  Widget buildImage(String path) => Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration(context) => DotsDecorator(
    size: const Size.square(10.0),
    activeSize: const Size(20.0, 10.0),
    activeColor: Theme.of(context).colorScheme.secondary,
    color: Colors.black26,
    spacing: const EdgeInsets.symmetric(horizontal: 3.0),
    activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0)
    ),
  );

  PageDecoration getPageDecoration() => PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    bodyTextStyle: TextStyle(fontSize: 20),
    // descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
    imagePadding: EdgeInsets.all(24),
    pageColor: Colors.white,
  );
}