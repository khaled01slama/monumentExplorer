import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import text-to-speech package

class MonumentDetailScreen extends StatefulWidget {
  final String name;
  final String imagePath;
  final String description;

  const MonumentDetailScreen({
    super.key,
    required this.name,
    required this.imagePath,
    required this.description,
  });

  @override
  _MonumentDetailScreenState createState() => _MonumentDetailScreenState();
}

class _MonumentDetailScreenState extends State<MonumentDetailScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  String _selectedLanguage = 'en-US'; // Default language

  // List of supported languages
  final List<Map<String, String>> _languages = [
    {'code': 'en-US', 'name': 'English (US)'},
    {'code': 'fr-FR', 'name': 'French'},
    {'code': 'es-ES', 'name': 'Spanish'},
    {'code': 'de-DE', 'name': 'German'},
  ];

  Future<void> _speak() async {
    await _flutterTts.setLanguage(_selectedLanguage);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(widget.description);
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  // Dropdown for language selection
                  DropdownButtonFormField<String>(
                    value: _selectedLanguage,
                    decoration: const InputDecoration(
                      labelText: 'Select Language',
                      border: OutlineInputBorder(),
                    ),
                    items: _languages.map((lang) {
                      return DropdownMenuItem<String>(
                        value: lang['code'],
                        child: Text(lang['name']!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _changeLanguage(value);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _speak, // Trigger text-to-speech
                    child: const Text('Play Voice Description'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
