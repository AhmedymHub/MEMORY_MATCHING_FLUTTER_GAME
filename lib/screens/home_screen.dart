import 'dart:async';
import 'package:flutter/material.dart';

import '../data/card_data.dart';
import '../models/card_model.dart';
import '../widgets/game_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CardModel> cards = [];

  CardModel? firstCard;
  CardModel? secondCard;

  int score = 0;
  int moves = 0;

  bool canFlip = true;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    cards = getCards();

    firstCard = null;
    secondCard = null;

    score = 0;
    moves = 0;

    canFlip = true;

    setState(() {});
  }

  void onCardTap(CardModel card) {
    if (!canFlip || card.isFlipped || card.isMatched) {
      return;
    }

    setState(() {
      card.isFlipped = true;
    });

    if (firstCard == null) {
      firstCard = card;
    } else {
      secondCard = card;
      moves++;
      canFlip = false;

      checkMatch();
    }
  }

  void checkMatch() {
    if (firstCard!.image == secondCard!.image) {
      setState(() {
        firstCard!.isMatched = true;
        secondCard!.isMatched = true;
        score++;
      });

      resetTurn();

      if (score == cards.length ~/ 2) {
        showWinDialog();
      }
    } else {
      Timer(const Duration(seconds: 1), () {
        setState(() {
          firstCard!.isFlipped = false;
          secondCard!.isFlipped = false;
        });

        resetTurn();
      });
    }
  }

  void resetTurn() {
    firstCard = null;
    secondCard = null;
    canFlip = true;
  }

  void showWinDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          '🎉 Congratulations!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'You matched all cards!\n\nMoves: $moves',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              startGame();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),

              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(14),
                    ),

                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  const Text(
                    'Memory Match',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),

                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade300,
                          Colors.deepOrange.shade400,
                        ],
                      ),

                      borderRadius: BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.35),
                          blurRadius: 8,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                          size: 24,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          '$score / ${cards.length ~/ 2}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Text(
              'Find all matching pairs! 🐾',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),

                itemCount: cards.length,

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 0.78,
                ),

                itemBuilder: (context, index) {
                  return GameCard(
                    card: cards[index],
                    onTap: () => onCardTap(cards[index]),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),

              child: TextButton.icon(
                onPressed: startGame,

                icon: const Icon(
                  Icons.refresh_rounded,
                  color: Colors.deepPurple,
                ),

                label: const Text(
                  'Restart',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}