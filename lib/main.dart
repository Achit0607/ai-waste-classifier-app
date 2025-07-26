import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() => runApp(WasteClassifierApp());

class WasteClassifierApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Classifier',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 16)),
      ),
      home: WasteClassifierHome(),
    );
  }
}

class WasteClassifierHome extends StatefulWidget {
  @override
  _WasteClassifierHomeState createState() => _WasteClassifierHomeState();
}

class _WasteClassifierHomeState extends State<WasteClassifierHome> {
  File? _image;
  String _prediction = '';
  bool _loading = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _prediction = '';
      });
      predictWaste(_image!);
    }
  }

  Future<void> predictWaste(File image) async {
    setState(() => _loading = true);

    try {
      final uri = Uri.parse('http://10.0.2.2:5000/predict');
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      final response = await request.send();
      final resBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final decoded = json.decode(resBody);
        setState(() {
          _prediction = decoded['prediction'] ?? 'Unknown';
        });
      } else {
        setState(() {
          _prediction = 'Error: Prediction failed';
        });
      }
    } catch (e) {
      setState(() {
        _prediction = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  Widget predictionCard(String prediction) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          'Prediction: $prediction',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[800]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Waste Classifier'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: Icon(Icons.image),
              label: Text('Pick Image from Gallery'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            if (_image != null)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(_image!, height: 220),
                ),
              ),
            if (_loading) CircularProgressIndicator(),
            if (_prediction.isNotEmpty && !_loading) predictionCard(_prediction),
          ],
        ),
      ),
    );
  }
}