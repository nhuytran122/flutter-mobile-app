class Product2 {
  final int id;
  final String title;
  final String category;
  final double price;
  final String image;
  final List<String>? tags;

  Product2({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.image,
    this.tags,
  });
}
