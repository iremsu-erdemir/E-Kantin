class CartItem {
  final String id;
  final String name;
  final String imagePath;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    this.quantity = 1,
  });

  // Backend için JSON dönüşümleri
  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json['id'],
    name: json['name'],
    imagePath: json['imagePath'],
    price: (json['price'] as num).toDouble(),
    quantity: json['quantity'] ?? 1,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imagePath': imagePath,
    'price': price,
    'quantity': quantity,
  };

  CartItem copyWith({
    String? id,
    String? name,
    String? imagePath,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
