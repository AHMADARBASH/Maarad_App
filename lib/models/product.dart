class Product {
  String id;
  String title;
  String description;
  double unitPrice;
  String category;
  String imageURL;

  Product(
      {required this.id,
      required this.title,
      required this.category,
      required this.description,
      required this.unitPrice,
      required this.imageURL});

  factory Product.fromJson(json) => Product(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      description: json['description'],
      unitPrice: json['unit_price'],
      imageURL: json['image']);
}
