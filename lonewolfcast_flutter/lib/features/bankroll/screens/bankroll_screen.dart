import 'package:flutter/material.dart';

class BankrollScreen extends StatelessWidget {
  const BankrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion Bankroll'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet, size: 50),
            SizedBox(height: 16),
            Text('Gestion de Bankroll'),
          ],
        ),
      ),
    );
  }
}