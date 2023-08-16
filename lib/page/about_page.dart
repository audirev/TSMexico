import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {

  @override
  _AboutPage createState() => _AboutPage();
}

class _AboutPage extends State<AboutPage> {

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Acerca de')
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sobre la app',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Esta app es gratuita, y se ha elaborado únicamente para organizar el fan project relativo al concierto de Taylor Swift en México. No busca ningún beneficio económico ni almacena ninguna información personal.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                'Sobre mí',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Desarrollador de software, aMante de la f1 🏁, pero sobretodo de la música de Taylor👱‍♀️❤️, que me ha acompañAdo desde hace más De una Década y ha sido la motivación para crear esta app.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Siéntete libre de contactar conmigo si tienes alguna nueva idea de cómo mejorar la app a través del correo: ingcordova2@gmail.com',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
              Text(
                'Gracias por su ayuda a:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 0),
              Text(
                'Benjamín Molina Sosa',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 0),
              Text(
                'Luis Ángel Hernández Calvo',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Versión 1.0.1',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
  );
}