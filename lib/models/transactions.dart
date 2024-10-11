class Transactions {
  final int? keyID;
  final String title;
  final String details;
  final String country;
  final String era;
  final String imageUrl;

  Transactions({
    this.keyID,
    required this.title,
    required this.details,
    required this.country,
    required this.era,
    required this.imageUrl,
  });
}
