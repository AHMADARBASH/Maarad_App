class Cart {
  final String id;
  final String productId;
  final double price;
  final int qty;
  final String title;
  Cart({
    required this.id,
    required this.title,
    required this.qty,
    required this.price,
    required this.productId,
  });
}
