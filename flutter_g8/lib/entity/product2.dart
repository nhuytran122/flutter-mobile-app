class Product2 {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  Product2({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product2.fromJson(Map<String, dynamic> json) {
    return Product2(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }

  static List<Product2> filterByCategory(
      List<Product2> products, String category) {
    var filteredProducts =
        products.where((product) => product.category == category).toList();
    return filteredProducts;
  }
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'],
      count: json['count'],
    );
  }
}
