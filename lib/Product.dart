import 'dart:ffi';

class Product {
  final int id;
  final String title;
  final String description;
  final String thumbnail;

  Product(this.id, this.title, this.description, this.thumbnail);
  // const Product(
  //     {required this.id, required this.title, required this.description});

  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(
  //     id: json['id'],
  //     title: json['title'],
  //     description: json['description'],
  //   );
  // }
}
