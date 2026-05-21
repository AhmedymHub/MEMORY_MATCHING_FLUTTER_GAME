import 'dart:math';
import 'package:flutter/material.dart';
import '../models/card_model.dart';

class GameCard extends StatelessWidget {
  final CardModel card;
  final VoidCallback onTap;

  const GameCard({
    super.key,
    required this.card,
    required this.onTap,
  });

  static final List<List<Color>> randomGradients = [
    [Colors.blue, Colors.lightBlueAccent],
    [Colors.red, Colors.orange],
    [Colors.green, Colors.lightGreen],
    [Colors.purple, Colors.deepPurpleAccent],
    [Colors.teal, Colors.cyan],
    [Colors.pink, Colors.pinkAccent],
    [Colors.indigo, Colors.blueAccent],
    [Colors.deepOrange, Colors.orangeAccent],
    [Colors.brown, Colors.amber],
    [Colors.deepPurple, Colors.purpleAccent],
  ];

  @override
  Widget build(BuildContext context) {

    final gradient =
    randomGradients[Random().nextInt(randomGradients.length)];

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(4),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),

          gradient: card.isFlipped || card.isMatched
              ? LinearGradient(
            colors: [
              Colors.white,
              Colors.grey.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          boxShadow: card.isMatched
              ? [
            BoxShadow(
              color: Colors.greenAccent.withOpacity(0.6),
              blurRadius: 18,
              spreadRadius: 2,
            ),
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(3, 5),
            ),
          ],
        ),

        child: card.isFlipped || card.isMatched
            ? Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            card.image,
            fit: BoxFit.contain,
          ),
        )
            : const Center(
          child: Text(
            '?',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}