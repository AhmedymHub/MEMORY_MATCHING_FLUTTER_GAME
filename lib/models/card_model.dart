class CardModel {
  final String image;
  bool isFlipped;
  bool isMatched;

  CardModel({
    required this.image,
    this.isFlipped = false,
    this.isMatched = false,
  });
}