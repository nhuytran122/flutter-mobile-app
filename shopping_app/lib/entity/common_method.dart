class CommonMethod {
  static double calculateOriginalPrice(
      double currentPrice, double salePercent) {
    return currentPrice / (1 - (salePercent / 100));
  }
}
