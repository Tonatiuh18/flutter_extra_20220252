import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paseme profe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DogImageViewer(),
    );
  }
}

class DogImageViewer extends StatefulWidget {
  @override
  _DogImageViewerState createState() => _DogImageViewerState();
}

class _DogImageViewerState extends State<DogImageViewer> {
  String imageUrl = '';

  void fetchImage() async {
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        imageUrl = jsonResponse['message'];
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paseme profe lo invito al cine :3'),
      ),
      body: Center(
        child: imageUrl.isEmpty
            ? Text(
                'Presiona el botón para ver una imagen de un perro random xd')
            : Image.network(imageUrl),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchImage,
        tooltip: 'Cargar Imagen',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
