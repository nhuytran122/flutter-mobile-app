class CommonMethod {
  static double calculateOriginalPrice(
      double currentPrice, double salePercent) {
    return currentPrice / (1 - (salePercent / 100));
  }

  static String formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }

  static String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
