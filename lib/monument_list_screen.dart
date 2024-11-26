import 'package:flutter/material.dart';
import 'monument_detail_screen.dart';

class MonumentListScreen extends StatelessWidget {
  final List<Map<String, String>> monuments = [
    {
      'name': 'Eiffel Tower',
      'image': 'assets/eiffel.jpg',
      'description':
      'One of the most iconic landmarks in the world, located in Paris, France. Built between 1887 and 1889 by engineer Gustave Eiffel...'
    },
    {
      'name': 'Leaning Tower of Pisa',
      'image': 'assets/pisa.jpg',
      'description':
      'A freestanding bell tower of the cathedral in Pisa, Italy, known worldwide for its unintended tilt...'
    },
    {
      'name': 'Colosseum',
      'image': 'assets/chateau.jpg',
      'description':
      'An oval amphitheater in the center of Rome, Italy. It is the largest ancient amphitheater ever built and remains iconic...'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Monument'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: monuments.length,
        itemBuilder: (ctx, index) {
          final monument = monuments[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MonumentDetailScreen(
                    name: monument['name']!,
                    imagePath: monument['image']!,
                    description: monument['description']!,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4,
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      monument['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                        child: Text(
                      monument['name']!,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
