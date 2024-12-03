import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoneWolfCast'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implémenter le filtre des matchs
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Section filtres date
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Matchs du jour',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // TODO: Ajouter DateSelector ici
          
          // Section matchs
          const Expanded(
            child: Center(
              child: Text('Liste des matchs à venir'),
            ),
          ),
        ],
      ),
    );
  }
}