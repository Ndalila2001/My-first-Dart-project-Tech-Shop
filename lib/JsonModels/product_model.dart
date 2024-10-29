import 'package:tech_shop_app2/data/product_data.dart';

class ProductModel {
  int id;
  String title;
  double price;
  int quantity;
  double total;
  double discountPercentage;
  double discountedTotal;
  String thumbnail;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
    this.isFavorite = false,
  });

  get product => null;
}

List<ProductModel> productList = products.map((data) {
  return ProductModel(
      id: data['id'],
      title: data['title'],
      price: data['price'],
      quantity: data['quantity'],
      total: data['total'],
      discountPercentage: data['discountPercentage'],
      discountedTotal: data['discountedTotal'],
      thumbnail: data['thumbnail']);
}).toList();
