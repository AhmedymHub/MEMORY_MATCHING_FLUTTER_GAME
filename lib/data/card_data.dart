import '../models/card_model.dart';

List<CardModel> getCards() {
  List<String> images = [
    'assets/images/cat.png',
    'assets/images/dog.png',
    'assets/images/lion.png',
    'assets/images/fox.png',
    'assets/images/rabbit.png',
    'assets/images/owl.png',
    'assets/images/tiger.png',
    'assets/images/panda.png',
    'assets/images/monkey.png',
    'assets/images/horse.png',
  ];

  List<CardModel> cards = [];

  for (var image in images) {
    cards.add(CardModel(image: image));
    cards.add(CardModel(image: image));
  }

  cards.shuffle();

  return cards;
}