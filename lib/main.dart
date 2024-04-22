import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Generador de Actividades Aleatorias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaActividadAleatoria(),
    );
  }
}

class PaginaActividadAleatoria extends StatefulWidget {
  @override
  _PaginaActividadAleatoriaState createState() =>
      _PaginaActividadAleatoriaState();
}

class _PaginaActividadAleatoriaState extends State<PaginaActividadAleatoria> {
  String _actividad = '';
  String _tipo = '';
  int _participantes = 0;
  double _precio = 0.0;
  double _accesibilidad = 0.0;

  Future<void> obtenerActividadAleatoria() async {
    final response =
        await http.get(Uri.parse('http://www.boredapi.com/api/activity/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _actividad = data['activity'];
        _tipo = data['type'];
        _participantes = data['participants'];
        _precio = data['price'].toDouble();
        _accesibilidad = data['accessibility'].toDouble();
      });
    } else {
      throw Exception('Error al cargar la actividad aleatoria');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerActividadAleatoria();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generador de Actividades Aleatorias'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_actividad',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Tipo: $_tipo',
              textAlign: TextAlign.center,
            ),
            Text(
              'Participantes: $_participantes',
              textAlign: TextAlign.center,
            ),
            Text(
              'Precio: $_precio',
              textAlign: TextAlign.center,
            ),
            Text(
              'Accesibilidad: $_accesibilidad',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: obtenerActividadAleatoria,
              child: Text('Obtener Otra Actividad'),
            ),
          ],
        ),
      ),
    );
  }
}
