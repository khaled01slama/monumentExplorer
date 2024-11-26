import 'package:flutter/material.dart';

class MonumentDetailScreen extends StatelessWidget {
  final String name;
  final String imagePath;
  final String description;

  MonumentDetailScreen({
    required this.name,
    required this.imagePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imagePath,
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
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: Text('Select Language'),
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
