class Order {
  String id;
  DateTime date;
  double total;
  List<String> items;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.items,
  });
}
