import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ts_mexico/model/song.dart';
import 'package:ts_mexico/page/onboarding_page.dart';

import '../services/data_service.dart';
import 'color_page.dart';

class SelectionPage extends StatefulWidget {  
  final List<String> colorOptions = ['Red', 'Green', 'Blue', 'Yellow'];

  @override
  _SelectionPage createState() => _SelectionPage();
}

class _SelectionPage extends State<SelectionPage> { 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Song> songs = new List.empty();
  
  Song? selectedSong;
  Color selectedColor = Colors.blue;
  String? userSectionId;

  @override
  void initState() {
    super.initState();
    loadNewLaunch();
    loadData();
  }

  loadNewLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _userSectionId = (prefs.getString('userSection') ?? null);

    setState(() {
      userSectionId = _userSectionId;
    });
  }


  loadData() async {
    var songsResponse = await loadSongs();
    songsResponse.sort((a, b) => a.name.compareTo(b.name));

    setState(() {      
      songs = songsResponse;
    });
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('TS México App')
          ),
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 191, 234),
                  /*
                  image: DecorationImage(
                    image: AssetImage("assets/bg1.png"),
                    fit: BoxFit.cover,
                  ),
                  */
                ),
                child: null /* add child content here */,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField<Song>(
                            value: selectedSong,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSong = newValue;
                              });
                              _getColorFromOption();
                            },
                            items: songs.map((Song mySong) {
                              return DropdownMenuItem<Song>(
                                value: mySong,
                                child: Text(mySong.name),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Selecciona la canción',
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'No olvides seleccionar una canción';
                              }
                              return null;
                            }
                          ),
                        )
                      ),
                      SizedBox(height: 24.0),
                      ElevatedButton(
                        onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            var color = await getColorCombination(selectedSong!.id, userSectionId!);
                            Navigator.pushNamed(
                              context,
                              ColorPage.routeName,
                              arguments: color,
                            );                     
                          }
                        },
                        child: Text(
                          'Generar Color',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          )),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedColor,
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: Size(100, 60)
                        ),
                      ),                                          
                    ],
                  ),
                )
              ),
              /*
              Positioned(
                bottom: 10,
                right: 0,
                child: ElevatedButton(
                  onPressed: () => goToOnBoarding(context),
                  child: Text('Ir a Onboarding'),
                )
              )
              */
            ],
          ),
        )
      );


  void goToOnBoarding(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => OnBoardingPage()),
  );

  void _getColorFromOption() async {
    var option = await getColorCombination(selectedSong!.id, userSectionId!);
    switch (option) {
      case 'Red':
        selectedColor = Colors.red;
      case 'Green':
        selectedColor = Colors.green;
      case 'Blue':
        selectedColor = Colors.blue;
      case 'Yellow':
        selectedColor = Colors.yellow;
      case 'Black':
        selectedColor = Colors.black;
      case 'Orange':
        selectedColor = Colors.orange;
      default:
        selectedColor = Colors.red;
    }
  }
}