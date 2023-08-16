import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ts_mexico/page/home_page.dart';

import '../services/data_service.dart';
import 'package:ts_mexico/model/section.dart';
import 'package:ts_mexico/model/zone.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Zone> zones = new List.empty();
  List<Section> sections = new List.empty();
  
  Zone? selectedZone;
  Section? selectedSection;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    var zoneResponse = await loadZones();
    zoneResponse.sort((a, b) => a.name.compareTo(b.name));

    setState(() {      
      zones = zoneResponse;
    });

    setUserData();
  }

  setUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userZone = (prefs.getString('userZone') ?? null);
    
    if (userZone == null) {
      return;
    }

    var userSelectedZone = zones.firstWhere((zone) => zone.id == userZone);
    await loadSectionsForZone(userSelectedZone);

    var userSection = (prefs.getString('userSection') ?? null);

    setState(() {
      selectedZone = userSelectedZone;
      selectedSection = sections.firstWhere((section) => section.id == userSection);
    });
  }

  loadSectionsForZone(Zone? zoneSelected) async {
    if (zoneSelected == null){
      return;
    }

    var sectionResponse = await loadSections();
    var sectionsForZone = sectionResponse.where((section) => section.zoneId == zoneSelected.id).toList();
    sectionsForZone.sort((a, b) => int.parse(a.name.replaceAll(new RegExp(r'[^0-9]'),'')).compareTo(int.parse(b.name.replaceAll(new RegExp(r'[^0-9]'),''))));
    
    setState(() {      
      sections = sectionsForZone;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Perfil Swiftie')
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
                    image: AssetImage("assets/bg3.png"),
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
                          child: DropdownButtonFormField<Zone>(
                            value: selectedZone,
                            onChanged: (newValue) {
                              setState(() {
                                selectedZone = newValue;
                                selectedSection = null;
                              });
                              loadSectionsForZone(newValue);
                            },
                            items: zones.map((Zone myZone) {
                              return DropdownMenuItem<Zone>(
                                value: myZone,
                                child: Text(myZone.name),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Zona',
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Selecciona una zona';
                              }
                              return null;
                            }
                          ),
                        )
                      ),
                      
                      SizedBox(height: 16.0),
                      
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField<Section>(
                            value: selectedSection,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSection = newValue;
                              });
                            },
                            items: sections.map((Section mySection) {
                              return DropdownMenuItem<Section>(
                                value: mySection,
                                child: Text(mySection.name),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Sección',
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Selecciona una sección';
                              }
                              return null;
                            }
                          ),
                        )
                      ),

                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            ProfileSaved();                      
                          }
                        },
                        child: Text('Guardar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => HomePage()),
  );

  void ProfileSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('filledProfile', true);
      prefs.setString('userZone', selectedZone!.id);
      prefs.setString('userSection', selectedSection!.id);
    });

    var snackBar = SnackBar(
      content: Text('Información Guardada'),
      action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            )
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    goToHome(context);
  }
}