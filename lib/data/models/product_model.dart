class ProductModel {
  final int id;
  final String title;
  final double price;
  final int? discount;
  final double? newPrice;
  final String description;
  final String image;
  final String category;
  final String brand;
  final int stock;
  final double rating;
  final bool isFlashSale;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    this.discount,
    this.newPrice,
    required this.description,
    required this.image,
    required this.category,
    required this.brand,
    required this.stock,
    required this.rating,
    this.isFlashSale = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      newPrice: json['new_price'] == null
          ? null
          : double.tryParse(json['new_price'].toString()),
      discount: json['discount'] == null
          ? null
          : int.tryParse(json['discount'].toString()),
      description: json['description'],
      image: json['image'],
      category: json['category'],
      brand: json['brand'] ?? 'Unknown',
      stock: json['stock'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isFlashSale: json['is_flash_sale'] ?? false,
    );
  }
}
