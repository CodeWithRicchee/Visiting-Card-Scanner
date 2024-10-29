import 'package:flutter/material.dart';
import '../models/card_model.dart';

class DisplayCardView extends StatelessWidget {
  final CardModel card;

  const DisplayCardView({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Card Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${card.name}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Phone: ${card.phone}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Email: ${card.email}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
